<?php

return function (CM_Config_Node $config) {

    $awsVersion = '<%= @aws_version %>';
    $awsRegion = '<%= @aws_region %>';
    $awsBucket = '<%= @aws_bucket %>';
    $awsKey = '<%= @aws_key %>';
    $awsSecret = '<%= @aws_secret %>';

    $config->services['s3export-filesystem-original'] = [
        'class'  => 'CM_File_Filesystem_Factory',
        'method' => [
            'name'      => 'createFilesystem',
            'arguments' => [
                'CM_File_Filesystem_Adapter_AwsS3',
                [
                    'version' => $awsVersion,
                    'region'  => $awsRegion,
                    'bucket'  => $awsBucket,
                    'key'     => $awsKey,
                    'secret'  => $awsSecret,
                ],
            ],
        ]];

    $config->services['s3export-backup-manager'] = [
        'class'     => 'S3Export_BackupManager',
        'arguments' => [
            [
                'version' => $awsVersion,
                'region'  => $awsRegion,
                'bucket'  => $awsBucket,
                'key'     => $awsKey,
                'secret'  => $awsSecret,
            ]
        ]
    ];
};
