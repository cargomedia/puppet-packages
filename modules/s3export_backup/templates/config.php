<?php

return function (CM_Config_Node $config) {

    $awsBucket = '<%= @awsBucket %>';
    $awsRegion = '<%= @awsRegion %>';
    $awsKey = '<%= @awsKey %>';
    $awsSecret = '<%= @awsSecret %>';

    $config->services['s3export-filesystem-original'] = array(
        'class'  => 'CM_File_Filesystem_Factory',
        'method' => array(
            'name'      => 'createFilesystem',
            'arguments' => array(
                'CM_File_Filesystem_Adapter_AwsS3',
                array(
                    'bucket' => $awsBucket,
                    'region' => $awsRegion,
                    'key'    => $awsKey,
                    'secret' => $awsSecret,
                ),
            ),
        ));

    $config->services['s3export-backup-manager'] = [
        'class'     => 'S3Export_BackupManager',
        'arguments' => [
            [
                'key'    => $awsKey,
                'secret' => $awsSecret,
            ]
        ]
    ];
};
