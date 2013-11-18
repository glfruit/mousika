package com.sanwn.mousika

import com.sanwn.mousika.Backup

class BackupController {

    static def timer = new Timer()

    class BackupTimeTask extends TimerTask{
        private String backupCommandFolder;
        public void setBackupCommandFolder(String backupCommandFolder){
            this.backupCommandFolder = backupCommandFolder
        }
        @Override
        public void run(){
            /*def backupInstanceList = Backup.getAll();
            def backupInstance = backupInstanceList.get(0);
            def dataBasePath = backupInstance.dataBasePath*/
            def os = System.getProperty("os.name").toLowerCase();
            def backupCommandLocation;
            def process;
            if(os.indexOf( "win" ) >= 0){
                backupCommandLocation = backupCommandFolder + "/backup.bat"
                process = Runtime.getRuntime().exec("cmd /c start "+backupCommandLocation)
                try {
                    process.waitFor()
                } catch (InterruptedException e) {
                    e.printStackTrace()
                }
            }else if (os.indexOf( "nix") >=0 || os.indexOf( "nux") >=0){
                backupCommandLocation =backupCommandFolder + "/backup.sh"
                process = Runtime.getRuntime().exec(backupCommandLocation)
                try {
                    process.waitFor()
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
        def os = System.getProperty("os.name").toLowerCase();
        def backupCommandLocation;
        def backupCommandFolder = request.getSession().getServletContext().getRealPath("/command");
        //备份到该系统的根目录下的backup文件夹下
        def backupPath = request.getSession().getServletContext().getRealPath("/backup");
        if(os.indexOf( "win" ) >= 0){
            backupCommandLocation = backupCommandFolder + "/backup.bat"
            dataBasePath = "\""+dataBasePath+"/bin/pg_dump.exe"+"\""
            File file = new File(backupCommandLocation)
            FileWriter fileWriter = new FileWriter(file)
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter)

            bufferedWriter.append("set PGPASSWORD=mousika_dev\n")
            Map envVarMap = System.getenv();
            dataBasePath = envVarMap.get("POSTGRESQL_HOME");

            if(dataBasePath != null && (!dataBasePath.equals(""))){
                dataBasePath = "\""+dataBasePath+"/bin/pg_dump.exe"+"\""
                bufferedWriter.append(dataBasePath)
            }

            bufferedWriter.append(" --host localhost --port 5432 --username \"mousika_dev\" --format custom --blobs --verbose --file \""+backupPath+"/mousika_dev-%date:~0,4%-%date:~5,2%-%date:~8,2%-%time:~0,2%-%time:~3,2%-%time:~6,2%.backup\"\n")
            bufferedWriter.append("exit")
            bufferedWriter.flush()
            fileWriter.close()
            bufferedWriter.close()

        }else if (os.indexOf( "nix") >=0 || os.indexOf( "nux") >=0){
            backupCommandLocation = backupCommandFolder + "/backup.sh"
            File file = new File(backupCommandLocation)
            FileWriter fileWriter = new FileWriter(file)
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter)

            bufferedWriter.append("#!/bin/bash\n")
            bufferedWriter.append("CURTIME=`date +\"%Y-%m-%d-%H-%M-%S\"`\n")
            bufferedWriter.append("export PGPASSWORD=mousika_dev\n")
            bufferedWriter.append("pg_dump --host localhost --port 5432 --username \"mousika_dev\" --format custom --blobs --verbose --file \""+backupPath+"/mousika_dev-\$CURTIME.backup\"\n")
            bufferedWriter.append("exit")
            bufferedWriter.flush()
            fileWriter.close()
            bufferedWriter.close()
        }

        backupInstance.save(failOnError: true)

        redirect(action: "list", params: params)
    }

    def manualBackup() {
        def backupCommandFolder = request.getSession().getServletContext().getRealPath("/command");
        def os = System.getProperty("os.name").toLowerCase();

        def backupCommandLocation
        def process
        if(os.indexOf( "win" ) >= 0){
            backupCommandLocation = backupCommandFolder + "/backup.bat"
            process = Runtime.getRuntime().exec("cmd.exe /c start " + backupCommandLocation)
            try {
                process.waitFor()
            } catch (InterruptedException e) {
                e.printStackTrace()
            }
        } else if (os.indexOf( "nix") >=0 || os.indexOf( "nux") >=0){
            backupCommandLocation = backupCommandFolder + "/backup.sh"
            process = Runtime.getRuntime().exec(backupCommandLocation)
            try {
                process.waitFor()
            } catch (InterruptedException e) {
                e.printStackTrace()
            }
        }
        redirect(action: "list", params: params)
    }

    def autoBackupStart(){
        redirect(action: "list", params: params)
        def backupCommandFolder = request.getSession().getServletContext().getRealPath("/command")

        def backupInstanceList = Backup.getAll();
        def backupInstance = backupInstanceList.get(0);

        def delay = (backupInstance.backupDelay*3600000).longValue()
        def period = (backupInstance.autoBackupPeriod*24*3600000).longValue()

        timer.cancel()
        timer = new Timer()
        def backupTimeTask = new BackupTimeTask();
        backupTimeTask.setBackupCommandFolder(backupCommandFolder)
        timer.schedule(backupTimeTask,delay,period)
    }

    def autoBackupStop(){
        redirect(action: "list", params: params)

        timer.cancel()
    }
}
