import com.sanwn.mousika.*
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

                    /*def teachingAffairsRole = new Role(name: "教务处")
                    teachingAffairsRole.addToPermissions("*:*")
                    teachingAffairsRole.save(failOnError: true)*/

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

                    /*def course = new Course(code:"1234567",courseToken: "aaaaaaa",title: "计算机网络",description:"测试",startDate:new Date(),guestVisible:true,available: true,numberOfWeeks:18,deliveredBy:User.findByUsername("系统管理员"))
                    course.save(failOnError: true)

                    def teaching = new Teaching(course:course,capability: 10,frequency: 3,assignmentTimes: 2,checkTimes: 6,time: 100)
                    teaching.save(failOnError: true)*/

                    def backup = new Backup(dataBasePath: "C:/Program Files/PostgreSQL/9.1/bin/pg_dump.exe", backupDelay: 0, autoBackupPeriod: 1.0)
                    backup.save(failOnError: true)

                    def privilegeResource = new PrivilegeResource(controllerEn: "course", controllerCn: "课程")
                    def privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "create", methodCn: "创建课程")
                    privilegeResourceMethod1.save(failOnError: true)
                    def privilegeResourceMethod2 = new PrivilegeResourceMethod(methodEn: "delete", methodCn: "删除课程")
                    privilegeResourceMethod2.save(failOnError: true)
                    def privilegeResourceMethod3 = new PrivilegeResourceMethod(methodEn: "list", methodCn: "列表")
                    privilegeResourceMethod3.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod2)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod3)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "user", controllerCn: "用户")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "create", methodCn: "创建用户")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResourceMethod2 = new PrivilegeResourceMethod(methodEn: "delete", methodCn: "删除用户")
                    privilegeResourceMethod2.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod2)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "student", controllerCn: "学生")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "list", methodCn: "列表")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "fileResource", controllerCn: "文件资源")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "list", methodCn: "列表")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "backup", controllerCn: "备份")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "list", methodCn: "列表")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "assignment", controllerCn: "作业")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "save", methodCn: "保存")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "auth", controllerCn: "认证")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "signIn", methodCn: "登录")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "forum", controllerCn: "论坛")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "show", methodCn: "显示")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "gradeBook", controllerCn: "成绩")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "show", methodCn: "显示")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "resource", controllerCn: "资源")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "save", methodCn: "保存")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "unitItem", controllerCn: "课程单元")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "copy", methodCn: "复制")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)
                }
            }
            production {

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

                    /*def teachingAffairsRole = new Role(name: "教务处")
                    teachingAffairsRole.addToPermissions("*:*")
                    teachingAffairsRole.save(failOnError: true)*/

                    def user = new User(username: "admin", fullname: "管理员", email: "admin@localhost.com", dateCreated: new Date(), passwordHash: new Sha256Hash("admin").toHex())
                    user.addToRoles(adminRole)
                    user.save(failOnError: true)

                    def backup = new Backup(dataBasePath: "C:/Program Files/PostgreSQL/9.1/bin/pg_dump.exe", backupDelay: 0, autoBackupPeriod: 1.0)
                    backup.save(failOnError: true)

                    def privilegeResource = new PrivilegeResource(controllerEn: "course", controllerCn: "课程")
                    def privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "create", methodCn: "创建课程")
                    privilegeResourceMethod1.save(failOnError: true)
                    def privilegeResourceMethod2 = new PrivilegeResourceMethod(methodEn: "delete", methodCn: "删除课程")
                    privilegeResourceMethod2.save(failOnError: true)
                    def privilegeResourceMethod3 = new PrivilegeResourceMethod(methodEn: "list", methodCn: "列表")
                    privilegeResourceMethod3.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod2)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod3)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "user", controllerCn: "用户")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "create", methodCn: "创建用户")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResourceMethod2 = new PrivilegeResourceMethod(methodEn: "delete", methodCn: "删除用户")
                    privilegeResourceMethod2.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod2)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "student", controllerCn: "学生")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "list", methodCn: "列表")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "fileResource", controllerCn: "文件资源")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "list", methodCn: "列表")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "backup", controllerCn: "备份")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "list", methodCn: "列表")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "assignment", controllerCn: "作业")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "save", methodCn: "保存")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "auth", controllerCn: "认证")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "signIn", methodCn: "登录")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "forum", controllerCn: "论坛")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "show", methodCn: "显示")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "gradeBook", controllerCn: "成绩")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "show", methodCn: "显示")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "resource", controllerCn: "资源")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "save", methodCn: "保存")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)

                    privilegeResource = new PrivilegeResource(controllerEn: "unitItem", controllerCn: "课程单元")
                    privilegeResourceMethod1 = new PrivilegeResourceMethod(methodEn: "copy", methodCn: "复制")
                    privilegeResourceMethod1.save(failOnError: true)
                    privilegeResource.addToPrivilegeResourceMethods(privilegeResourceMethod1)
                    privilegeResource.save(failOnError: true)
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
