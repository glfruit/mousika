import com.sanwn.mousika.Role
import com.sanwn.mousika.User

build {
    role(Role, name: 'admin')
    user(User, roles: [role])
}