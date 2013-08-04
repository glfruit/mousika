import com.sanwn.mousika.Backup
import com.sanwn.mousika.Role
import com.sanwn.mousika.User
import org.apache.shiro.crypto.hash.Sha256Hash

class BootStrap {

    def searchableService

    def init = { servletContext ->
        environments {
            development {

                if (!User.count()) {
                    def adminRole = new Role(name: "系统管理员")
                    adminRole.addToPermissions("*:*")
                    adminRole.save(failOnError: true)

                    def teacherRole = new Role(name: "教师")
                    teacherRole.addToPermissions("course:*")
                    teacherRole.addToPermissions("assignment:*")
                    teacherRole.addToPermissions("page:*")
                    teacherRole.addToPermissions("feedback:*")
                    teacherRole.addToPermissions("attempt:show")
                    teacherRole.save(failOnError: true)

                    def courseMgrRole = new Role(name: "课程负责人")
                    courseMgrRole.addToPermissions("course:*")
                    courseMgrRole.save(failOnError: true)

                    def studentRole = new Role(name: "学生")
                    studentRole.addToPermissions("student:*")
                    studentRole.addToPermissions("course:index,list")
                    studentRole.addToPermissions("assignment:show")
                    studentRole.addToPermissions("attempt:create,update")
                    studentRole.addToPermissions("feedback:show")
                    studentRole.save(failOnError: true)

                    def teachingAffairsRole = new Role(name: "教务处")
                    teachingAffairsRole.addToPermissions("*:*")
                    teachingAffairsRole.save(failOnError: true)

                    def user = new User(username: "admin", fullname: "无名氏", email: "ppller25@126.com", dateCreated: new Date(), passwordHash: new Sha256Hash("admin").toHex())
                    user.addToRoles(adminRole)
                    user.save(failOnError: true)

                    user = new User(username: "glfruit", fullname: "李果", email: "glfruit80@gmail.com", dateCreated: new Date(), passwordHash: new Sha256Hash("test").toHex())
                    user.addToRoles(teacherRole)
                    user.save(failOnError: true)

                    user = new User(username: "linda", fullname: "李彦熹", email: "linda@123.com", dateCreated: new Date(), passwordHash: new Sha256Hash("test").toHex())
                    user.addToRoles(studentRole)
                    user.save(failOnError: true)

                    user = new User(username: "test1", fullname: "彭启华", email: "ppller25@126.com", dateCreated: new Date(), passwordHash: new Sha256Hash("test").toHex())
                    user.save(failOnError: true)

                    def backup = new Backup(dataBasePath: "D:/Program Files/PostgreSQL/9.1/bin/pg_dump.exe",backupDelay: 0, autoBackupPeriod: 1.0)
                    backup.save(failOnError: true)
                }
            }
        }
        println "Performing bulk index"
        searchableService.reindex()
        println "Starting mirror service"
        searchableService.startMirroring()

    }
    def destroy = {
    }
}
