# docker-golang-builder
Đây là một Dockerfile dùng để build một ứng dụng bất ký được viết bằng GoLang


## Lưu ý
- Source tự động được checkou tại folder **/build/src**
- Tất cả dependencies được lấy về tự động
- Docker dùng scratch nên đảm bảo là nhỏ nhất.

## Build Command

```
git clone http://git.anphabe.net/devops/docker-golang-docker-builder 

cd docker-golang-docker-builder

docker build --build-arg CODE_URL=http://git.sth -t YOUR_TAG_NAME .
```


## Đối với ứng dụng cần cấu hình trước:
- Lưu ý kết quả build luôn được tạo ra hoàn hảo ở vị trí /go/bin/main
- Chỉ cần thêm vào cuối Dockerfile để tạo ra file config phù hợp.