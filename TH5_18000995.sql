USE quanlydean;

-- 1.
SELECT phongban.TENPHG, diadiem_phg.DIADIEM
FROM phongban, diadiem_phg
WHERE phongban.MAPHG = diadiem_phg.MAPHG;

-- 2.
SELECT phongban.TENPHG, nhanvien.TENNV
FROM phongban, nhanvien
WHERE phongban.TRPHG = nhanvien.MANV;

-- 3.
SELECT nhanvien.TENNV, nhanvien.DCHI
FROM nhanvien, phongban
WHERE nhanvien.PHG = phongban.MAPHG AND phongban.TENPHG = 'Nghiên cứu';

-- 4.
SELECT dean.TENDA, phongban.TENPHG, CONCAT(nhanvien.HONV, ' ', nhanvien.TENLOT, ' ', nhanvien.TENNV) AS TENTRGPHG, phongban.NG_NHANCHUC
FROM dean
LEFT JOIN (phongban LEFT JOIN nhanvien 
           ON phongban.TRPHG = nhanvien.MANV)
ON dean.PHONG = phongban.MAPHG
WHERE dean.DDIEM_DA = 'Hà Nội';

-- 5.
SELECT nhanvien.TENNV, thannhan.TENTN
FROM nhanvien, thannhan
WHERE nhanvien.MANV = thannhan.MA_NVIEN AND nhanvien.PHAI = 'Nữ';

-- 6.
SELECT CONCAT(nhanvien1.HONV, ' ', nhanvien1.TENLOT, ' ', nhanvien1.TENNV) AS HOTENNV, CONCAT(nhanvien2.HONV, ' ', nhanvien2.TENLOT, ' ', nhanvien2.TENNV) AS HOTEN_NQL
FROM nhanvien AS nhanvien1, nhanvien AS nhanvien2
WHERE nhanvien1.MA_NQL = nhanvien2.MANV;

-- 7.
SELECT CONCAT(nhanvien1.HONV, ' ', nhanvien1.TENLOT, ' ', nhanvien1.TENNV) AS HOTENNV, CONCAT(nhanvien3.HONV, ' ', nhanvien3.TENLOT, ' ', nhanvien3.TENNV) AS HOTEN_TRGPHG, CONCAT(nhanvien2.HONV, ' ', nhanvien2.TENLOT, ' ', nhanvien2.TENNV) AS HOTEN_NQL
FROM (nhanvien AS nhanvien1 
      LEFT JOIN nhanvien AS nhanvien2 
      ON nhanvien1.MA_NQL = nhanvien2.MANV)
LEFT JOIN (phongban LEFT JOIN (nhanvien AS nhanvien3) 
           ON phongban.TRPHG = nhanvien3.MANV)
ON nhanvien1.PHG = phongban.MAPHG;

-- 8.
SELECT nhanvien.TENNV
FROM nhanvien, (SELECT phancong.MA_NVIEN
      FROM phancong, dean
      WHERE phancong.MADA = dean.MADA AND dean.TENDA = 'San pham X') AS nv_tg
WHERE nhanvien.MANV = nv_tg.MA_NVIEN AND nhanvien.PHG = 5
AND nhanvien.MA_NQL = (SELECT MANV FROM nhanvien WHERE HONV = 'Nguyễn' AND TENLOT = 'Thanh' AND TENNV = 'Tùng');

-- 9.
SELECT dean.TENDA
FROM ((nhanvien RIGHT JOIN phancong ON nhanvien.MANV = phancong.MA_NVIEN)
      RIGHT JOIN dean
      ON phancong.MADA = dean.MADA)
WHERE nhanvien.HONV = 'Đinh' AND nhanvien.TENLOT = 'Bá' AND nhanvien.TENNV = 'Tiên';

-- 10
SELECT COUNT(dean.MADA) AS SL_DA
FROM dean;

-- 11.
SELECT COUNT(*) AS SL_DA
FROM dean LEFT JOIN phongban
ON dean.PHONG = phongban.MAPHG
GROUP BY phongban.TENPHG
HAVING phongban.TENPHG = 'Nghiên cứu';

-- 12.
SELECT AVG(nhanvien.LUONG) AS LG_TB
FROM nhanvien
GROUP BY nhanvien.PHAI
HAVING nhanvien.PHAI = 'Nữ';

-- 13.
SELECT COUNT(*) AS SO_TN
FROM thannhan
LEFT JOIN nhanvien
ON thannhan.MA_NVIEN = nhanvien.MANV
WHERE CONCAT(nhanvien.HONV, ' ', nhanvien.TENLOT, ' ', nhanvien.TENNV) = 'Đinh Bá Tiên';

-- 14
SELECT dean.TENDA, TONGTG
FROM dean, (SELECT MADA, SUM(phancong.THOIGIAN) AS TONGTG FROM phancong GROUP BY MADA) AS tg_da
WHERE dean.MADA = tg_da.MADA;

-- 15.
SELECT MADA, COUNT(MA_NVIEN) AS SL_NV
FROM phancong
GROUP BY MADA;

-- 16.
SELECT CONCAT(nhanvien.HONV, ' ', nhanvien.TENLOT, ' ', nhanvien.TENNV) AS HOTEN_NV, COUNT(thannhan.TENTN) AS SO_TN
FROM nhanvien 
RIGHT JOIN thannhan 
ON nhanvien.MANV = thannhan.MA_NVIEN
GROUP BY thannhan.MA_NVIEN;

-- 17.
SELECT CONCAT(nhanvien.HONV, ' ', nhanvien.TENLOT, ' ', nhanvien.TENNV) AS HOTEN_NV, COUNT(phancong.MADA) AS SO_DA
FROM nhanvien 
RIGHT JOIN phancong
ON nhanvien.MANV = phancong.MA_NVIEN
GROUP BY phancong.MA_NVIEN;

-- 18.
SELECT nhanvien1.MANV, COUNT(nhanvien2.MANV) AS SL_NVQL
FROM nhanvien AS nhanvien1
LEFT JOIN nhanvien AS nhanvien2
ON nhanvien1.MANV = nhanvien2.MA_NQL
GROUP BY nhanvien1.MANV;

-- 19.
SELECT phongban.TENPHG, AVG(nhanvien.LUONG) AS LUONG_TB
FROM phongban
LEFT JOIN nhanvien
ON phongban.MAPHG = nhanvien.PHG
GROUP BY phongban.MAPHG;

-- 20.
SELECT phongban.TENPHG, COUNT(nhanvien.MANV) AS SO_NV
FROM phongban
LEFT JOIN nhanvien
ON phongban.MAPHG = nhanvien.PHG
GROUP BY phongban.MAPHG
HAVING AVG(nhanvien.LUONG) > 30000;

-- 21.
SELECT phongban.TENPHG, COUNT(*) AS SO_DA
FROM phongban
LEFT JOIN dean
ON phongban.MAPHG = dean.PHONG
GROUP BY phongban.MAPHG;

-- 22.
SELECT phongban.TENPHG, CONCAT(nhanvien.HONV, ' ', nhanvien.TENLOT, ' ', nhanvien.TENNV) AS HOTEN_TP, COUNT(*) AS SO_DA 
FROM phongban, nhanvien, dean
WHERE phongban.MAPHG = dean.PHONG AND phongban.TRPHG = nhanvien.MANV
GROUP BY phongban.MAPHG;

-- 23.
SELECT phongban.TENPHG, COUNT(dean.MADA) AS SO_DA
FROM phongban, dean
WHERE phongban.MAPHG = dean.PHONG AND phongban.MAPHG IN (SELECT nhanvien.PHG 
                                                         FROM nhanvien 
                                                         GROUP BY nhanvien.PHG 
                                                         HAVING AVG(nhanvien.LUONG) > 40000)
GROUP BY phongban.MAPHG;

-- 24.
SELECT dean.DDIEM_DA, COUNT(*) AS SO_DA
FROM dean
GROUP BY dean.DDIEM_DA;

-- 25.
SELECT dean.TENDA, COUNT(congviec.TEN_CONG_VIEC) AS SO_CV
FROM dean, congviec
WHERE dean.MADA = congviec.MADA
GROUP BY dean.TENDA;

-- 26.
SELECT congviec.TEN_CONG_VIEC, COUNT(*) AS SL_NV
FROM congviec, phancong
WHERE congviec.MADA = phancong.MADA AND congviec.STT = phancong.STT AND congviec.MADA = 30
GROUP BY congviec.TEN_CONG_VIEC;

-- 27.
SELECT congviec.TEN_CONG_VIEC, COUNT(*) AS SL_NV
FROM congviec, phancong, dean
WHERE congviec.MADA = phancong.MADA AND congviec.STT = phancong.STT AND congviec.MADA = dean.MADA AND dean.TENDA = 'Dao tao'
GROUP BY congviec.TEN_CONG_VIEC;










