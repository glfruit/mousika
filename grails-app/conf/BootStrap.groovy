import com.sanwn.mousika.domain.Role
import com.sanwn.mousika.domain.User
import org.apache.shiro.crypto.hash.Sha256Hash

class BootStrap {

    def init = { servletContext ->
        def user = new User(username: "test", passwordHash: new Sha256Hash("test").toHex())
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
