Thời gian hoàn thành 1 tháng.

I - Giao đoạn 1
  1 : Login
      - Mục đích để các bạn làm quen với view cơ bản như textview, textfield, button, label. Đồng thời bắt và xử lý các sự kiện từ view.
      - Yêu cầu :
           + Tạo giao diện màn hình login cơ bản.Gồm logo, loginform (nhập username, password..).
           + Tạo màn hình register
           + Xử lý bàn phím khi nhập text
           + Validate email và password (>6), khi vaildate ok thì chuyển sang main app (App sẽ có dạng tabbar, gồm 1 tab là timeline và 1 tab my profile)

  2 : Main app : Gồm 2 tab (Timeline, MyPage)
     - Mục đich làm quen với tableview (view dùng nhiều nhất khi viết app), di chuyển giữa các view, pass data giữa các viewcontroller.Ngoài ra, các bạn còn biết và sử dụng các ContainerViewController như TabbarController , NavigationViewController và học cách sử dụng camera để chụp ảnh
     - Yêu cầu :
         + Tab Timeline: gồm 3 màn hình (Timelines , TimelineComment, TimelinePost)
               ++ Timelines : Sử dụng tableview để hiển thị.Dữ liệu hiện tại fix cứng tầm 20 cái
               ++ Timelines : Mỗi cell sẽ hiển thị thông tin (gồm status, tên, thời gian, ...)
               ++ Timelines : Mỗi cell sẽ có 3 nút like, comment và share bên dưới
               ++ Khi bấm nút comment thì chuyển sang màn hình TimelineComment (Push) và hiển thị chi tiết cell đó
               ++ TimelineComment : Click back button trở về màn hình TimelineComment
               ++ Trên navigation bar sẽ có nút post trên top right.Click vào chuyển sang màn hình TimelinePost (Present)
              ++ TimelinePost: Màn hình tạo timeline cho phép nhập thông tin status.Khi click ok thì sẽ ẩn xuống và tạo thêm 1 cell mới ở màn hình Timelines

      + Tab MyPage : gồm 2 màn hình (Profile , ProfileEdit)
               ++ Profile : hiển thị thông tin của user : Avatar, name, email, birthdate,...
               ++ Profile : Click nút edit ở tabbar top right chuyển sang màn hình ProfileEdit
               ++ ProfileEdit : màn hình này sử dụng camera chup ảnh avatar, thay đổi thông tin username, email, birthdate và khi click save thì đẩy thông tin về màn hình Profile

II - Giao đoạn 2 
   Bắt đầu áp dụng networking
    1 - Màn login : 
           - Login với user và password có sẵn.
           - Làm quen với cơ chế authen như oauth2.0, và xử lý authen
           - Tìm cách lưu thông tin user để các màn hình sử dụng
    2 - Màn Timelines
           - Hiển thị thông tin timelines đc get từ server
           - Xử lý loadmore (mỗi page là 10 bản ghi)
           - Xử lý refresh
           ....
    3 - Màn TimelinePost
           - Nhập thông tin status và Post lên server.
    4 - Màn ProfileEdit
           - Thay đổi thông tin user
           - Upload ảnh lên server kèm thông tin (multipartFormData)

II - Giao đoạn 3
  - Áp dụng database (coredata, realm ...)