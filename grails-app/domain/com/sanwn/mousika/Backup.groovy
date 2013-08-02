package com.sanwn.mousika

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-8-2
 * Time: 下午7:50
 * To change this template use File | Settings | File Templates.
 */
class Backup {
    static searchable = true

    String dataBasePath

    float backupDelay

    float autoBackupPeriod

    static mapping = {
        table 'backup'
    }
}
