package com.sanwn.mousika.controllers

import com.sanwn.mousika.Backup

class BackupController {

    static def timer = new Timer()

    class BackupTimeTask extends TimerTask{
        @Override
        public void run(){
            def backupInstanceList = Backup.getAll();
            def backupInstance = backupInstanceList.get(0);
            def dataBasePath = backupInstance.dataBasePath
            def userDir = System.getProperty("user.dir")
            def os = System.getProperty("os.name").toLowerCase();
            def backupCommandLocation = "/grails-app/command/backup.bat"
            if(os.indexOf( "win" ) >= 0){
                def child = Runtime.getRuntime().exec("cmd.exe /c start "+userDir+backupCommandLocation)
                try {
                    child.waitFor()
                } catch (InterruptedException e) {
                    e.printStackTrace()
                }
            }
        }

    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(){
        def backupInstanceList = Backup.getAll();
        def backupInstance = backupInstanceList.get(0);
        [backupInstance: backupInstance]
    }

    def save(){
        def backupInstanceList = Backup.getAll();
        def backupInstance = backupInstanceList.get(0);
        backupInstance.setDataBasePath(params.get("dataBasePath"))
        backupInstance.setAutoBackupPeriod(params.float("autoBackupPeriod"))

        //更新脚本
        def dataBasePath = backupInstance.dataBasePath
        def userDir = System.getProperty("user.dir")
        def os = System.getProperty("os.name").toLowerCase();
        def backupCommandLocation = "/grails-app/command/backup.bat"
        //备份到该系统的根目录下的backup文件夹下
        def backupPath = userDir+"/backup"
        if(os.indexOf( "win" ) >= 0){
            dataBasePath = "\""+dataBasePath+"\""
            FileWriter fileWriter = new FileWriter(userDir+backupCommandLocation)
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter)

            bufferedWriter.append("set PGPASSWORD=mousika_dev\n")
            bufferedWriter.append(dataBasePath)
            bufferedWriter.append(" --host localhost --port 5432 --username \"mousika_dev\" --format custom --blobs --verbose --file \""+backupPath+"/mousika_dev-%date:~0,4%-%date:~5,2%-%date:~8,2%-%time:~0,2%-%time:~3,2%-%time:~6,2%.dump\"")
            bufferedWriter.append("\nexit")
            bufferedWriter.flush()
            fileWriter.close()
            bufferedWriter.close()
        }

        backupInstance.save(failOnError: true)

        redirect(action: "list", params: params)
    }

    def manualBackup() {
        def userDir = System.getProperty("user.dir")
        def os = System.getProperty("os.name").toLowerCase();
        def backupCommandLocation = "/grails-app/command/backup.bat"
        if(os.indexOf( "win" ) >= 0){
            def child = Runtime.getRuntime().exec("cmd.exe /c start "+userDir+backupCommandLocation)
            try {
                child.waitFor()
            } catch (InterruptedException e) {
                e.printStackTrace()
            }
        }
        redirect(action: "list", params: params)
    }

    def autoBackupStart(){
        redirect(action: "list", params: params)

        def backupInstanceList = Backup.getAll();
        def backupInstance = backupInstanceList.get(0);

        def delay = (backupInstance.backupDelay*3600000).longValue()
        def period = (backupInstance.autoBackupPeriod*24*3600000).longValue()

        timer.cancel()
        timer = new Timer()
        timer.schedule(new BackupTimeTask(),delay,period)
    }

    def autoBackupStop(){
        redirect(action: "list", params: params)

        timer.cancel()
    }
}
