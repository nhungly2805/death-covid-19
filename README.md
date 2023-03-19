# death-covid-19

Covid-19 vẫn đang gây ảnh hưởng nặng nề trên toàn thế giới. Các nhà nghiên cứu vẫn không ngừng tìm hiểu xem các yếu tố nào ảnh hưởng đến số người tử vong do Covid-19. Bài viết này nghiên cứu tác động của một số nhân tố đến số người tử vong do Covid-19 ở các quốc gia. Bài viết sử dụng dữ liệu của 151 quốc gia, sử dụng thống kê mô tả và thực hiện phân tích hồi quy tuyến tính bội để xác định được yếu tố ảnh hưởng đến số người tử vong vì Covid-19.

Nghiên cứu sử dụng tập hợp dữ liệu Covid-19 được cập nhật mỗi ngày bởi Our World in Data. Dữ liệu được trích xuất vào ngày 15/10/2021. Nghiên cứu sử dụng dữ liệu của 151 quốc gia trên khắp thế giới, sử dụng biến phụ thuộc là số ca tử vong vì Covid-19 và các biến độc lập: GDP trên đầu người, tỷ lệ mắc bệnh tiểu đường (% dân số tuổi từ 20-79 năm 2017), dân số năm 2020, tổng số liều vắc-xin được tiêm, tỷ lệ dân số từ 70 tuổi trở lên vào năm 2015, chỉ số HDI cao (0,7 – 0,799), chỉ số HDI trung bình (0,55-0,699), chỉ số HDI thấp (<0,55). 

Phương trình hồi quy được sử dụng như sau:
Lndeath = β0 + β1*gdp_per_capital + β2*diabetes_prevalence + β3*ln_pop + β4*ln_vaccine + β5*aged_70_older + β6*low_HDI + β7*medium_HDI + β8*high_HDI + εi
