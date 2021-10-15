# Account Number
$account_no = 111562214993


#Retention
$retentiontype = 'Weekly'

#Remove old backups 
$Retention = 3


######### Start Functions
function Add-EC2Tag 
{

Param (
      [string][Parameter(Mandatory=$True)]$key,
      [string][Parameter(Mandatory=$True)]$value,
      [string][Parameter(Mandatory=$True)]$resourceId
      )

    $Tag = New-Object amazon.EC2.Model.Tag
    $Tag.Key = $Key
    $Tag.Value = $value

    New-EC2Tag -ResourceId $resourceId -Tag $Tag | Out-Null
}

function Get-EC2VolumeTag
{

Param (
      [string][Parameter(Mandatory=$True)]$Tag,
      [string][Parameter(Mandatory=$True)]$Value
      )

Get-EC2Volume | Where-Object {$_.Tag.Key -eq $tag -and $_.Tag.Value -eq $value -and $_.Tag.Key -eq 'RetentionType' -and $_.Tag.Value -eq $retentiontype}

}

#Find the instance the volume is connected to
function Get-VolumeInfo 
{
Param (
       [Parameter(Mandatory=$True)]$volume
       )
       $instanceId = $backupVolume.attachment[0].instanceid 
       $reservation = Get-EC2Instance -Instance $instanceId
       $instance = $reservation.RunningInstance
       $Name = ($instance.Tag | Where-Object {$_.Key -eq 'Name'}).Value
     
       return $Name 

}

######### End Functions
$backupDate = Get-Date -f 'yyyy-MM-dd'
######### Start Work

function start_tag
{
    #Tag each volume to ensure it gets backed up
    Get-EC2Volume | ForEach-Object {
           $backupKey = $false
           $_.Tag | ForEach-Object { if ($_.Key -eq 'BackupEnabled') {$backupKey = $true} }
           If ($backupKey -eq $false)
           {
                $volumeId = $_.VolumeId
                Write-Output "Enabling backup for $volumeId"
                Add-EC2Tag -key 'BackupEnabled' -value 'False' -resourceId $volumeId #change value to True for default true backup
                Add-EC2Tag -key 'RetentionType' -value 'None' -resourceId $volumeId #Default None; change to Daily,Weekly,Monthly              
           }
    }
}

function start_backup
{
    #Retrieve all volumes that should be backed up
    #$backupVolumes = Get-EC2VolumeTag -Tag 'BackupEnabled' -Value 'True'

    #Backup each volume and apply tag information to the volume and snapshot
    Foreach ($backupVolume in $backupVolumes)
    {
      if ($backupVolume.attachment)
      {
        $deviceattch = $backupVolume.Attachment.Device
        $Name = Get-VolumeInfo -volume $backupVolume
        $snapshot = New-Ec2snapshot -VolumeId $backupVolume.volumeID -Description "Backup for $Name | $deviceattch | $backupDate"
        Write-Output "Backup for $Name | $deviceattch | $backupDate"
        $volName = ($backupVolume.tag | Where-Object {$_.Key -eq 'Name'}).Value

        Add-EC2Tag -key 'BackupDate' -value $backupDate -resourceId $backupVolume.volumeID
        Add-EC2Tag -key 'BackupDelete' -value 'True' -resourceId $snapshot.SnapshotId 
        Add-EC2Tag -key 'BackupDate' -value $backupDate -resourceId $snapshot.SnapshotId
        if ($volName) {Add-EC2Tag -key 'Name' -value $volName -resourceId $snapshot.SnapshotId}
      }
    }
}




function remove_backups
{
    #Remove old backups
    # Set Account
    $Filter = new-object Amazon.EC2.Model.Filter
    $Filter.Name = "owner-id"
    $Filter.Value = "$account_no"
    # Set Tag filter
    $Filter1 = new-object Amazon.EC2.Model.Filter
    $Filter1.Name = "tag:BackupDelete"
    $Filter1.Value = "True"

    $SnapshotsToDelete = Get-EC2Snapshot -Filter $Filter, $Filter1 `
                        | where-object { $_.volumeId -in $backupVolumes.volumeId } `
                        | group-object -Property VolumeId `
                        | where-object {$_.group.count -gt $Retention}

    foreach ($SnapshotToDelete in $SnapshotsToDelete)
        {
        $Snapcount = $SnapshotToDelete.count - $Retention
        $SnapshotToDelete.group | Sort-Object { $_.starttime -as [datetime] } | select -First $Snapcount `
        | ForEach-Object {Remove-EC2Snapshot -SnapshotId $_.SnapshotId -Force }


        }
    

}
$backupVolumes = Get-EC2VolumeTag -Tag 'BackupEnabled' -Value 'True'
start_tag
start_backup
remove_backups