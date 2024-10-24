# Thành viên nhóm #
| STT | Họ và tên          | Mã số sinh viên |
|-----|--------------------|-----------------|
| 1   | Hứa Hồ Gia Huy      | 21522143        |
| 2   | Quách Minh Huy      | 21522164        |
| 3   | Nguyễn Hoàng Diệp Phi|21522453  |

# Trước khi chạy source cần cấu hình aws credentials : #
   - Trên terminal nhập : `aws configure` 
    rồi cung cấp access + secret key 
- Sử dụng mail giảng viên hướng dẫn được cấp quyền mới truy cập được file credentials : https://drive.google.com/file/d/1YLf-f6ByiCqeqF4T0g3E9m-8-4EXBeKi/view?usp=drive_link 
# Script chạy source code terraform: #

`terraform init -> terraform fmt -> terraform validate -> terraform plan -> terraform apply -> yes`

# Triển khai dùng cloudformation #
 - upload file yaml lên aws cloudformation -> add a tag Name -> Next triển khai
 - Có thể chỉnh sửa cloudformation file dùng cloudformation infrastructure composer
 - Sơ đồ cloudformation stack : 
   ![image](https://github.com/user-attachments/assets/2b3bdf82-e588-457e-8f71-34313599b07a)

# Testing

## Install
- GO Framework: [Download](https://go.dev/doc/install)
- Thêm gói Terraform trên GO: `go get github.com/gruntwork-io/terratest/modules/aws@v0.47.2`

## Usage
- Mở termninal trong thư mục test, run `go test -v`

## Kết quả
![Test](https://drive.google.com/thumbnail?id=1rhkWTQnex8tCd6K1uwuTCnQCeOxiMQWf)



