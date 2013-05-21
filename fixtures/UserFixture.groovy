import com.sanwn.mousika.domain.Role
import com.sanwn.mousika.domain.User

build {
    role(Role, name: 'admin')
    user(User, roles: [role])
}