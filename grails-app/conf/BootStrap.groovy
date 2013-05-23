import com.sanwn.mousika.domain.Role
import com.sanwn.mousika.domain.User
import org.apache.shiro.crypto.hash.Sha256Hash

class BootStrap {

    def init = { servletContext ->
        environments {
            development {

                if (!User.count()) {
                    def adminRole = new Role(name: "系统管理员")
                    adminRole.addToPermissions("*:*")
                    adminRole.save(failOnError: true)

                    def teacherRole = new Role(name: "教师")
                    teacherRole.addToPermissions("course:index,list,show,admin,save,edit,update")
                    teacherRole.save(failOnError: true)

                    def courseMgrRole = new Role(name: "课程负责人")
                    courseMgrRole.addToPermissions("course:*")
                    courseMgrRole.save(failOnError: true)

                    def studentRole = new Role(name: "学生")
                    studentRole.addToPermissions("course:list,show")
                    studentRole.save(failOnError: true)

                    def user = new User(username: "admin", fullname: "无名氏", email: "ppller25@126.com", dateCreated: new Date(), passwordHash: new Sha256Hash("admin").toHex())
                    user.addToRoles(adminRole)
                    user.save(failOnError: true)

                    user = new User(username: "glfruit", fullname: "李果", email: "glfruit80@gmail.com", dateCreated: new Date(), passwordHash: new Sha256Hash("test").toHex())
                    user.save(failOnError: true)

                    user = new User(username: "linda", fullname: "李彦熹", email: "linda@123.com", dateCreated: new Date(), passwordHash: new Sha256Hash("test").toHex())
                    user.save(failOnError: true)

                    user = new User(username: "test1", fullname: "彭启华", email: "ppller25@126.com", dateCreated: new Date(), passwordHash: new Sha256Hash("test").toHex())
                    user.save(failOnError: true)
                }
            }
        }
    }
    def destroy = {
    }
}
