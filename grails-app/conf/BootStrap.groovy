import com.sanwn.mousika.domain.User
import org.apache.shiro.crypto.hash.Sha256Hash

class BootStrap {

    def init = { servletContext ->
        def user = new User(username: "test", passwordHash: new Sha256Hash("test").toHex())
        user.addToPermissions("*:*")
        user.save()
    }
    def destroy = {
    }
}
