import com.sanwn.mousika.domain.Role
import com.sanwn.mousika.domain.User
import org.apache.shiro.crypto.hash.Sha256Hash

class BootStrap {

    def init = { servletContext ->
        def user = new User(username: "test", fullname: "彭启华", email: "ppller25@126.com", passwordHash: new Sha256Hash("test").toHex())
        user.addToPermissions("*:*")
        user.save()

        user = new User(username: "glix", fullname: "李果", email: "glfruit80@gmail.com", passwordHash: new Sha256Hash("test").toHex())
        user.addToPermissions("*:*")
        user.save()

        user = new User(username: "linda", fullname: "李彦熹", email: "linda@123.com", passwordHash: new Sha256Hash("test").toHex())
        user.addToPermissions("*:*")
        user.save()

        def role = new Role(name: "系统管理员")
        role.addToPermissions("*:*")
        role.save()
        role = new Role(name: "教师")
        role.addToPermissions("*:*")
        role.save()
        role = new Role(name: "课程负责人")
        role.addToPermissions("*:*")
        role.save()
        role = new Role(name: "学生")
        role.addToPermissions("*:*")
        role.save()
    }
    def destroy = {
    }
}
