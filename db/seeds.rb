admin = User.new(
    email:      'admin@outdoor.sy',
    password:   'password',
    password_confirmation: 'password'
)

p "1 admin created: Username: admin@outdoor.sy, Password: password"

admin.save!
