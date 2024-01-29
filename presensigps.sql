/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : presensigps

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 15/01/2024 16:50:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cabang
-- ----------------------------
DROP TABLE IF EXISTS `cabang`;
CREATE TABLE `cabang`  (
  `kode_cabang` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_cabang` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi_cabang` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `radius_cabang` int NOT NULL,
  PRIMARY KEY (`kode_cabang`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cabang
-- ----------------------------
INSERT INTO `cabang` VALUES ('BDG', 'BANDUNG', '-7.32787621654869,108.21411457050611', 300);
INSERT INTO `cabang` VALUES ('PST', 'PUSAT', '-7.321942518196893,107.86029333749414', 30);
INSERT INTO `cabang` VALUES ('TSM', 'Tasikmalaya', '-7.291093861247671, 108.23192043374881', 30);

-- ----------------------------
-- Table structure for departemen
-- ----------------------------
DROP TABLE IF EXISTS `departemen`;
CREATE TABLE `departemen`  (
  `kode_dept` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_dept` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kode_dept`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of departemen
-- ----------------------------
INSERT INTO `departemen` VALUES ('HRD', 'Human Resource Development ');
INSERT INTO `departemen` VALUES ('IT', 'Information Technology');
INSERT INTO `departemen` VALUES ('KEU', 'Keuangan');
INSERT INTO `departemen` VALUES ('MKT', 'Marketing');

-- ----------------------------
-- Table structure for jam_kerja
-- ----------------------------
DROP TABLE IF EXISTS `jam_kerja`;
CREATE TABLE `jam_kerja`  (
  `kode_jam_kerja` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_jam_kerja` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `awal_jam_masuk` time NOT NULL,
  `jam_masuk` time NOT NULL,
  `akhir_jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  `lintashari` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_jam_kerja`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jam_kerja
-- ----------------------------
INSERT INTO `jam_kerja` VALUES ('JK01', 'NON SHIFT', '00:00:00', '08:00:00', '22:00:00', '22:00:00', '0');
INSERT INTO `jam_kerja` VALUES ('JK02', 'NON SHIFT SABTU', '05:00:00', '07:00:00', '08:00:00', '12:00:00', '0');
INSERT INTO `jam_kerja` VALUES ('JK03', 'SHIFT 2', '14:00:00', '15:00:00', '22:40:00', '23:00:00', '0');
INSERT INTO `jam_kerja` VALUES ('JK04', 'SHIFT MALAM', '21:00:00', '23:00:00', '23:59:00', '07:00:00', '1');

-- ----------------------------
-- Table structure for karyawan
-- ----------------------------
DROP TABLE IF EXISTS `karyawan`;
CREATE TABLE `karyawan`  (
  `nik` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_lengkap` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jabatan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_hp` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `foto` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_dept` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_cabang` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `remember_token` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`nik`) USING BTREE,
  INDEX `fk_karyawan_cabang`(`kode_cabang` ASC) USING BTREE,
  INDEX `fk_karyawan_dept`(`kode_dept` ASC) USING BTREE,
  CONSTRAINT `fk_karyawan_cabang` FOREIGN KEY (`kode_cabang`) REFERENCES `cabang` (`kode_cabang`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_karyawan_dept` FOREIGN KEY (`kode_dept`) REFERENCES `departemen` (`kode_dept`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of karyawan
-- ----------------------------
INSERT INTO `karyawan` VALUES ('10-10', 'Mimin', 'Staff HRD', '089646441111', NULL, 'HRD', 'PST', '$2y$10$cGEx7um6eqQe/ZO/NF2Awu2teKARkC.Fqu0mCFE1PZLsg8IyfImWu', NULL);
INSERT INTO `karyawan` VALUES ('12345', 'Fitriani Nurhidayah', 'Head of IT', '089670444322', '12345.png', 'IT', 'BDG', '$2y$10$FtZIbp8L5701hxSWp/3UQuNor2YtrvuPcwIadWZAEfZQv2uEd09jS', NULL);
INSERT INTO `karyawan` VALUES ('12347', 'Qiana', 'Accounting', '0', NULL, 'KEU', 'PST', '$2y$10$Yj9EYsOhvx8UwQxvQuRyy.9I8jr0.Zk7.2zA9ZstzxVv.88CxJFEy', NULL);
INSERT INTO `karyawan` VALUES ('12349', 'Daffa', 'Staff IT', '0899999', '12349.jpg', 'IT', 'BDG', '$2y$10$r9UwFWkuhIraL2MUgnkqKu2KkDyD87QI.7F1BkiNOG.rTpPCxzs76', NULL);
INSERT INTO `karyawan` VALUES ('22-01', 'Abdurahman', 'IT', '089888877771', NULL, 'IT', 'BDG', '$2y$10$8diaDmODyZo4lmmEv19BNeyLx6XUYCksxmUJPzIaK9C6L/.nb9/jW', NULL);
INSERT INTO `karyawan` VALUES ('2501', 'Atep', 'Security', '0892317171717', '23-01.png', 'HRD', 'TSM', '$2y$10$HpCUI3meMQopwfv0I8OLwOum48Qmel4ryBsPnkr7YmQ0Lf6OiM/jy', NULL);
INSERT INTO `karyawan` VALUES ('3636', 'Adam Abdi Al Ala S.Kom', 'Manager HRD', '082220804021', '12346.png', 'HRD', 'BDG', '$2y$10$/7PU0LlKeeoLLwEh/MvdAu5.7slx8hvBiUG8x3SNSNyZ1VdHxSnZ6', NULL);
INSERT INTO `karyawan` VALUES ('8888', 'Hilman Firdaus', 'IT Staff', '098787657567', '8888.jpg', 'IT', 'PST', '$2y$10$YtB4VujsRVwnpF.3sJ9bA.ReCq3HR/uql1gbWA8sTGog5jORxlhKO', NULL);
INSERT INTO `karyawan` VALUES ('99-99', 'Dedy', 'Staff Keuangan', '0822211211', NULL, 'HRD', 'BDG', '$2y$10$kCHWKvIClL3Jp5we6R7RZ.3k3FjplEeJH2pDmNUSzJhi38F3jUuIi', NULL);
INSERT INTO `karyawan` VALUES ('9999', 'Dadang', 'Staff IT', '0898888', NULL, 'IT', 'BDG', '$2y$10$u.Cpy.8nxTlHUJFMB2lHTeSyQpOw2Zx7MRu2fuT/nndxMigccZWFW', NULL);

-- ----------------------------
-- Table structure for konfigurasi_jamkerja
-- ----------------------------
DROP TABLE IF EXISTS `konfigurasi_jamkerja`;
CREATE TABLE `konfigurasi_jamkerja`  (
  `nik` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hari` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_jam_kerja` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `fk_kj_karyawan`(`nik` ASC) USING BTREE,
  INDEX `fk_kj_jk`(`kode_jam_kerja` ASC) USING BTREE,
  CONSTRAINT `fk_kj_jk` FOREIGN KEY (`kode_jam_kerja`) REFERENCES `jam_kerja` (`kode_jam_kerja`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_kj_karyawan` FOREIGN KEY (`nik`) REFERENCES `karyawan` (`nik`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of konfigurasi_jamkerja
-- ----------------------------
INSERT INTO `konfigurasi_jamkerja` VALUES ('22-01', 'Senin', NULL);
INSERT INTO `konfigurasi_jamkerja` VALUES ('22-01', 'Selasa', NULL);
INSERT INTO `konfigurasi_jamkerja` VALUES ('22-01', 'Rabu', NULL);
INSERT INTO `konfigurasi_jamkerja` VALUES ('22-01', 'Kamis', NULL);
INSERT INTO `konfigurasi_jamkerja` VALUES ('22-01', 'Jumat', NULL);
INSERT INTO `konfigurasi_jamkerja` VALUES ('22-01', 'Sabtu', NULL);
INSERT INTO `konfigurasi_jamkerja` VALUES ('22-01', 'Minggu', NULL);
INSERT INTO `konfigurasi_jamkerja` VALUES ('3636', 'Senin', 'JK01');
INSERT INTO `konfigurasi_jamkerja` VALUES ('3636', 'Selasa', 'JK01');
INSERT INTO `konfigurasi_jamkerja` VALUES ('3636', 'Rabu', 'JK03');
INSERT INTO `konfigurasi_jamkerja` VALUES ('3636', 'Kamis', 'JK02');
INSERT INTO `konfigurasi_jamkerja` VALUES ('3636', 'Jumat', 'JK01');
INSERT INTO `konfigurasi_jamkerja` VALUES ('3636', 'Sabtu', 'JK01');
INSERT INTO `konfigurasi_jamkerja` VALUES ('3636', 'Minggu', 'JK01');
INSERT INTO `konfigurasi_jamkerja` VALUES ('12345', 'Senin', 'JK01');
INSERT INTO `konfigurasi_jamkerja` VALUES ('12345', 'Selasa', 'JK01');
INSERT INTO `konfigurasi_jamkerja` VALUES ('12345', 'Rabu', 'JK01');
INSERT INTO `konfigurasi_jamkerja` VALUES ('12345', 'Kamis', 'JK01');
INSERT INTO `konfigurasi_jamkerja` VALUES ('12345', 'Jumat', NULL);
INSERT INTO `konfigurasi_jamkerja` VALUES ('12345', 'Sabtu', NULL);
INSERT INTO `konfigurasi_jamkerja` VALUES ('12345', 'Minggu', 'JK01');

-- ----------------------------
-- Table structure for konfigurasi_jamkerja_by_date
-- ----------------------------
DROP TABLE IF EXISTS `konfigurasi_jamkerja_by_date`;
CREATE TABLE `konfigurasi_jamkerja_by_date`  (
  `nik` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `kode_jam_kerja` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `fk_kjbydate_karyawan`(`nik` ASC) USING BTREE,
  CONSTRAINT `fk_kjbydate_karyawan` FOREIGN KEY (`nik`) REFERENCES `karyawan` (`nik`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of konfigurasi_jamkerja_by_date
-- ----------------------------
INSERT INTO `konfigurasi_jamkerja_by_date` VALUES ('22-01', '2024-01-01', 'JK01');
INSERT INTO `konfigurasi_jamkerja_by_date` VALUES ('22-01', '2024-02-01', 'JK03');
INSERT INTO `konfigurasi_jamkerja_by_date` VALUES ('3636', '2024-01-12', 'JK03');
INSERT INTO `konfigurasi_jamkerja_by_date` VALUES ('3636', '2024-01-15', 'JK04');
INSERT INTO `konfigurasi_jamkerja_by_date` VALUES ('2501', '2024-01-12', 'JK01');
INSERT INTO `konfigurasi_jamkerja_by_date` VALUES ('3636', '2024-01-16', 'JK01');
INSERT INTO `konfigurasi_jamkerja_by_date` VALUES ('12345', '2024-01-13', 'JK04');

-- ----------------------------
-- Table structure for konfigurasi_jk_dept
-- ----------------------------
DROP TABLE IF EXISTS `konfigurasi_jk_dept`;
CREATE TABLE `konfigurasi_jk_dept`  (
  `kode_jk_dept` char(7) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_cabang` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_dept` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_jk_dept`) USING BTREE,
  INDEX `fk_kjd_cabang`(`kode_cabang` ASC) USING BTREE,
  INDEX `fk_kjd_dept`(`kode_dept` ASC) USING BTREE,
  CONSTRAINT `fk_kjd_cabang` FOREIGN KEY (`kode_cabang`) REFERENCES `cabang` (`kode_cabang`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_kjd_dept` FOREIGN KEY (`kode_dept`) REFERENCES `departemen` (`kode_dept`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of konfigurasi_jk_dept
-- ----------------------------
INSERT INTO `konfigurasi_jk_dept` VALUES ('JBDGIT', 'BDG', 'IT');
INSERT INTO `konfigurasi_jk_dept` VALUES ('JBDGKEU', 'BDG', 'KEU');
INSERT INTO `konfigurasi_jk_dept` VALUES ('JTSMKEU', 'TSM', 'KEU');

-- ----------------------------
-- Table structure for konfigurasi_jk_dept_detail
-- ----------------------------
DROP TABLE IF EXISTS `konfigurasi_jk_dept_detail`;
CREATE TABLE `konfigurasi_jk_dept_detail`  (
  `kode_jk_dept` char(7) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hari` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_jam_kerja` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `fk_jkdept`(`kode_jk_dept` ASC) USING BTREE,
  CONSTRAINT `fk_jkdept` FOREIGN KEY (`kode_jk_dept`) REFERENCES `konfigurasi_jk_dept` (`kode_jk_dept`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of konfigurasi_jk_dept_detail
-- ----------------------------
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JTSMKEU', 'Senin', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JTSMKEU', 'Selasa', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JTSMKEU', 'Rabu', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JTSMKEU', 'Kamis', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JTSMKEU', 'Jumat', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JTSMKEU', 'Sabtu', 'JK02');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGKEU', 'Senin', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGKEU', 'Selasa', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGKEU', 'Rabu', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGKEU', 'Kamis', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGKEU', 'Jumat', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGKEU', 'Sabtu', 'JK02');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGIT', 'Senin', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGIT', 'Selasa', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGIT', 'Rabu', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGIT', 'Kamis', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGIT', 'Jumat', 'JK01');
INSERT INTO `konfigurasi_jk_dept_detail` VALUES ('JBDGIT', 'Sabtu', 'JK02');

-- ----------------------------
-- Table structure for master_cuti
-- ----------------------------
DROP TABLE IF EXISTS `master_cuti`;
CREATE TABLE `master_cuti`  (
  `kode_cuti` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_cuti` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jml_hari` smallint NULL DEFAULT NULL,
  PRIMARY KEY (`kode_cuti`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of master_cuti
-- ----------------------------
INSERT INTO `master_cuti` VALUES ('C01', 'Tahunan', 12);
INSERT INTO `master_cuti` VALUES ('C02', 'Cuti Melahirkan', 90);
INSERT INTO `master_cuti` VALUES ('C04', 'Cuti Menikah', 2);

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (2, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (3, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (4, '2023_12_14_233749_create_permission_tables', 1);
INSERT INTO `migrations` VALUES (5, '2023_12_15_002819_create_permission_tables', 2);

-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions`  (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_permissions_model_id_model_type_index`(`model_id` ASC, `model_type` ASC) USING BTREE,
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of model_has_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles`  (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_roles_model_id_model_type_index`(`model_id` ASC, `model_type` ASC) USING BTREE,
  CONSTRAINT `fk_users` FOREIGN KEY (`model_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
INSERT INTO `model_has_roles` VALUES (2, 'App\\Models\\User', 8);
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\User', 9);
INSERT INTO `model_has_roles` VALUES (2, 'App\\Models\\User', 10);
INSERT INTO `model_has_roles` VALUES (2, 'App\\Models\\User', 12);

-- ----------------------------
-- Table structure for pengajuan_izin
-- ----------------------------
DROP TABLE IF EXISTS `pengajuan_izin`;
CREATE TABLE `pengajuan_izin`  (
  `kode_izin` char(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nik` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_izin_dari` date NULL DEFAULT NULL,
  `tgl_izin_sampai` date NULL DEFAULT NULL,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'i : izin s : sakit',
  `kode_cuti` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `doc_sid` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_approved` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0' COMMENT '0 : Pending 1: Disetuji 2: Ditolak',
  PRIMARY KEY (`kode_izin`) USING BTREE,
  INDEX `fk_pengajuan_karyawan`(`nik` ASC) USING BTREE,
  INDEX `fk_pengajuan_cuti`(`kode_cuti` ASC) USING BTREE,
  CONSTRAINT `fk_pengajuan_cuti` FOREIGN KEY (`kode_cuti`) REFERENCES `master_cuti` (`kode_cuti`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_pengajuan_karyawan` FOREIGN KEY (`nik`) REFERENCES `karyawan` (`nik`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pengajuan_izin
-- ----------------------------
INSERT INTO `pengajuan_izin` VALUES ('IZ1123001', '3636', '2023-11-06', '2023-11-08', 'i', NULL, 'Acara Keluarga', NULL, '1');
INSERT INTO `pengajuan_izin` VALUES ('IZ1123002', '3636', '2023-11-09', '2023-11-09', 's', NULL, 'Panas Demam', 'IZ1123002.jpg', '1');
INSERT INTO `pengajuan_izin` VALUES ('IZ1123003', '3636', '2023-11-10', '2023-11-10', 'c', 'C01', 'Liburan', NULL, '1');
INSERT INTO `pengajuan_izin` VALUES ('IZ1223001', '12345', '2023-12-22', '2023-12-22', 'i', NULL, 'Acara Keluarga', NULL, '1');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `permissions_name_guard_name_unique`(`name` ASC, `guard_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (1, 'view-karyawan', 'web', '2023-12-15 00:36:28', '2023-12-15 00:36:28');
INSERT INTO `permissions` VALUES (2, 'view-departemen', 'web', '2023-12-15 00:36:28', '2023-12-15 00:36:28');

-- ----------------------------
-- Table structure for presensi
-- ----------------------------
DROP TABLE IF EXISTS `presensi`;
CREATE TABLE `presensi`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nik` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_presensi` date NOT NULL,
  `jam_in` time NULL DEFAULT NULL,
  `jam_out` time NULL DEFAULT NULL,
  `foto_in` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `foto_out` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lokasi_in` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `lokasi_out` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `kode_jam_kerja` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_izin` char(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_presensi_karyawan`(`nik` ASC) USING BTREE,
  INDEX `fk_prensesi_pengajuan_izin`(`kode_izin` ASC) USING BTREE,
  INDEX `fk_presensi_jk`(`kode_jam_kerja` ASC) USING BTREE,
  CONSTRAINT `fk_prensesi_pengajuan_izin` FOREIGN KEY (`kode_izin`) REFERENCES `pengajuan_izin` (`kode_izin`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_presensi_jk` FOREIGN KEY (`kode_jam_kerja`) REFERENCES `jam_kerja` (`kode_jam_kerja`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_presensi_karyawan` FOREIGN KEY (`nik`) REFERENCES `karyawan` (`nik`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of presensi
-- ----------------------------
INSERT INTO `presensi` VALUES (1, '3636', '2023-11-04', '14:29:52', NULL, '12346-2023-11-04-in.png', NULL, '-7.291087300105089,108.23191923404895', NULL, 'JK01', 'h', NULL);
INSERT INTO `presensi` VALUES (14, '3636', '2023-11-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'i', 'IZ1123001');
INSERT INTO `presensi` VALUES (15, '3636', '2023-11-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'i', 'IZ1123001');
INSERT INTO `presensi` VALUES (16, '3636', '2023-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'i', 'IZ1123001');
INSERT INTO `presensi` VALUES (17, '3636', '2023-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 's', 'IZ1123002');
INSERT INTO `presensi` VALUES (18, '3636', '2023-11-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'c', 'IZ1123003');
INSERT INTO `presensi` VALUES (19, '22-01', '2023-11-11', '20:05:35', NULL, '22-01-2023-11-11-in.png', NULL, '-6.570933,107.777931', NULL, 'JK01', 'h', NULL);
INSERT INTO `presensi` VALUES (21, '3636', '2023-11-23', '00:35:43', '22:37:58', '12346-2023-11-23-in.png', '12346-2023-11-23-out.png', '-7.2909825,108.2335175', '-7.3279,108.214', 'JK01', 'h', NULL);
INSERT INTO `presensi` VALUES (22, '3636', '2023-12-07', '22:24:05', '07:34:45', '12346-2023-12-07-in.png', '12346-2023-12-07-out.png', '-7.3021734,108.2259013', '-7.3021734,108.2259013', 'JK04', 'h', NULL);
INSERT INTO `presensi` VALUES (23, '12345', '2023-12-07', '22:29:07', NULL, '12345-2023-12-07-in.png', NULL, '-7.3021734,108.2259013', NULL, 'JK03', 'h', NULL);
INSERT INTO `presensi` VALUES (25, '3636', '2023-12-08', '22:01:31', NULL, '12346-2023-12-08-in.png', NULL, '-7.3279,108.214', NULL, 'JK03', 'h', NULL);
INSERT INTO `presensi` VALUES (26, '3636', '2023-12-19', '19:23:57', NULL, '12346-2023-12-19-in.png', NULL, '-7.3269248,108.2195968', NULL, 'JK01', 'h', NULL);
INSERT INTO `presensi` VALUES (27, '3636', '2023-12-22', '14:02:14', NULL, '12346-2023-12-22-in.png', NULL, '-7.3505808,108.2171633', NULL, 'JK03', 'h', NULL);
INSERT INTO `presensi` VALUES (28, '12345', '2023-12-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'i', 'IZ1223001');
INSERT INTO `presensi` VALUES (29, '12345', '2024-01-13', '21:41:47', NULL, '12345-2024-01-13-in.png', NULL, '-7.3279,108.214', NULL, 'JK04', 'h', NULL);

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions`  (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `role_id`) USING BTREE,
  INDEX `role_has_permissions_role_id_foreign`(`role_id` ASC) USING BTREE,
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_has_permissions
-- ----------------------------
INSERT INTO `role_has_permissions` VALUES (1, 1);
INSERT INTO `role_has_permissions` VALUES (2, 1);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `roles_name_guard_name_unique`(`name` ASC, `guard_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'administrator', 'web', '2023-12-15 00:36:28', '2023-12-15 00:36:28');
INSERT INTO `roles` VALUES (2, 'admin departemen', 'web', '2023-12-18 00:22:14', '2023-12-18 00:22:14');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_dept` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `kode_cabang` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (8, 'Maman', 'maman@gmail.com', NULL, '$2y$10$5KAJ9bbfApiggsMxCjEHTOq8qTxlIeGCgttEf.sf3O2bNuhMW25.G', 'IT', 'PST', NULL, '2023-12-18 22:43:16', '2023-12-18 22:43:16');
INSERT INTO `users` VALUES (9, 'Adam Adifa', 'adam@gmail.com', NULL, '$2y$10$QyRg7XiipzUiFQjwLD/aFOYqimZNNwi65yH76hRybocmt0N0Cjbye', 'IT', 'PST', NULL, '2023-12-18 22:45:36', '2023-12-18 22:45:36');
INSERT INTO `users` VALUES (10, 'Fitriani', 'fitriani@gmail.com', NULL, '$2y$10$Sf3Gb.hSt54gj3pflkf1dufGXmBC3GGz0Up4LTywaZOhsKorpUzuS', 'KEU', 'TSM', NULL, '2023-12-22 10:48:45', '2023-12-22 10:48:45');
INSERT INTO `users` VALUES (12, 'Qiana', 'qiana@gmail.com', NULL, '$2y$10$7WKBW.2e7L4p1lyKnELAeOjsemSQa1Oib8GGpZhmkWe9rKACXZUl6', 'IT', 'BDG', NULL, '2023-12-22 10:53:17', '2023-12-22 10:53:17');

-- ----------------------------
-- View structure for q_rekappresensi
-- ----------------------------
DROP VIEW IF EXISTS `q_rekappresensi`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `q_rekappresensi` AS select `karyawan`.`nik` AS `nik`,`karyawan`.`nama_lengkap` AS `nama_lengkap`,`karyawan`.`jabatan` AS `jabatan`,`presensi`.`tgl_1` AS `tgl_1`,`presensi`.`tgl_2` AS `tgl_2`,`presensi`.`tgl_3` AS `tgl_3`,`presensi`.`tgl_4` AS `tgl_4`,`presensi`.`tgl_5` AS `tgl_5`,`presensi`.`tgl_6` AS `tgl_6`,`presensi`.`tgl_7` AS `tgl_7`,`presensi`.`tgl_8` AS `tgl_8`,`presensi`.`tgl_9` AS `tgl_9`,`presensi`.`tgl_10` AS `tgl_10`,`presensi`.`tgl_11` AS `tgl_11`,`presensi`.`tgl_12` AS `tgl_12`,`presensi`.`tgl_13` AS `tgl_13`,`presensi`.`tgl_14` AS `tgl_14`,`presensi`.`tgl_15` AS `tgl_15`,`presensi`.`tgl_16` AS `tgl_16`,`presensi`.`tgl_17` AS `tgl_17`,`presensi`.`tgl_18` AS `tgl_18`,`presensi`.`tgl_19` AS `tgl_19`,`presensi`.`tgl_20` AS `tgl_20`,`presensi`.`tgl_21` AS `tgl_21`,`presensi`.`tgl_22` AS `tgl_22`,`presensi`.`tgl_23` AS `tgl_23`,`presensi`.`tgl_24` AS `tgl_24`,`presensi`.`tgl_25` AS `tgl_25`,`presensi`.`tgl_26` AS `tgl_26`,`presensi`.`tgl_27` AS `tgl_27`,`presensi`.`tgl_28` AS `tgl_28`,`presensi`.`tgl_29` AS `tgl_29`,`presensi`.`tgl_30` AS `tgl_30`,`presensi`.`tgl_31` AS `tgl_31` from (`karyawan` left join (select `presensi`.`nik` AS `nik`,max(if((`presensi`.`tgl_presensi` = '2023-11-01'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_1`,max(if((`presensi`.`tgl_presensi` = '2023-11-02'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_2`,max(if((`presensi`.`tgl_presensi` = '2023-11-03'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_3`,max(if((`presensi`.`tgl_presensi` = '2023-11-04'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_4`,max(if((`presensi`.`tgl_presensi` = '2023-11-05'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_5`,max(if((`presensi`.`tgl_presensi` = '2023-11-06'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_6`,max(if((`presensi`.`tgl_presensi` = '2023-11-07'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_7`,max(if((`presensi`.`tgl_presensi` = '2023-11-08'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_8`,max(if((`presensi`.`tgl_presensi` = '2023-11-09'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_9`,max(if((`presensi`.`tgl_presensi` = '2023-11-10'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_10`,max(if((`presensi`.`tgl_presensi` = '2023-11-11'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_11`,max(if((`presensi`.`tgl_presensi` = '2023-11-12'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_12`,max(if((`presensi`.`tgl_presensi` = '2023-11-13'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_13`,max(if((`presensi`.`tgl_presensi` = '2023-11-14'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_14`,max(if((`presensi`.`tgl_presensi` = '2023-11-15'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_15`,max(if((`presensi`.`tgl_presensi` = '2023-11-16'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_16`,max(if((`presensi`.`tgl_presensi` = '2023-11-17'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_17`,max(if((`presensi`.`tgl_presensi` = '2023-11-18'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_18`,max(if((`presensi`.`tgl_presensi` = '2023-11-19'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_19`,max(if((`presensi`.`tgl_presensi` = '2023-11-20'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_20`,max(if((`presensi`.`tgl_presensi` = '2023-11-21'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_21`,max(if((`presensi`.`tgl_presensi` = '2023-11-22'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_22`,max(if((`presensi`.`tgl_presensi` = '2023-11-23'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_23`,max(if((`presensi`.`tgl_presensi` = '2023-11-24'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_24`,max(if((`presensi`.`tgl_presensi` = '2023-11-25'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_25`,max(if((`presensi`.`tgl_presensi` = '2023-11-26'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_26`,max(if((`presensi`.`tgl_presensi` = '2023-11-27'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_27`,max(if((`presensi`.`tgl_presensi` = '2023-11-28'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_28`,max(if((`presensi`.`tgl_presensi` = '2023-11-29'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_29`,max(if((`presensi`.`tgl_presensi` = '2023-11-30'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_30`,max(if((`presensi`.`tgl_presensi` = '2023-11-31'),concat(convert(ifnull(`presensi`.`jam_in`,'NA') using latin1),'|',convert(ifnull(`presensi`.`jam_out`,'NA') using latin1),'|',ifnull(`presensi`.`status`,'NA'),'|',ifnull(`jam_kerja`.`nama_jam_kerja`,'NA'),'|',convert(ifnull(`jam_kerja`.`jam_masuk`,'NA') using latin1),'|',convert(ifnull(`jam_kerja`.`jam_pulang`,'NA') using latin1),'|',ifnull(`presensi`.`kode_izin`,'NA'),'|',ifnull(`pengajuan_izin`.`keterangan`,'NA'),'|'),NULL)) AS `tgl_31` from ((`presensi` left join `jam_kerja` on((`presensi`.`kode_jam_kerja` = `jam_kerja`.`kode_jam_kerja`))) left join `pengajuan_izin` on((`presensi`.`kode_izin` = `pengajuan_izin`.`kode_izin`))) group by `presensi`.`nik`) `presensi` on((`karyawan`.`nik` = `presensi`.`nik`)));

SET FOREIGN_KEY_CHECKS = 1;
