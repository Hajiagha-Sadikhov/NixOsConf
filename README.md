NixOS qurulumu, digər Linux dağıtımlarından fərqli olaraq tamamilə deklarativ bir struktura sahibdir. Yəni, sistemin konfiqurasiyasını bir fayl üzərindən təyin edib, bütün sistemi həmin fayla görə qura bilərsiniz. Budur, əsas NixOS qurulumu üçün addımlar:

### 1. Yükləmə və USB-ə Yazma
- NixOS-un ISO faylını [rəsmi saytından](https://nixos.org/download.html) yükləyin.
- ISO faylını USB yaddaş qurğusuna yazmaq üçün `dd` və ya bənzər bir alət istifadə edə bilərsiniz. Məsələn:
  ```bash
  sudo dd if=nixos-x86_64-linux-*-iso of=/dev/sdX bs=4M status=progress oflag=sync
  ```
  Burada `/dev/sdX` USB qurğusunun yoludur. `X` hissəsini doğru şəkildə dəyişdirin.

### 2. Canlı Mühitə Başlatma
- USB-ni kompüterinizə taxın və NixOS Live mühitinə boot edin. Kompüterinizin BIOS/UEFI ayarlarından USB-dən boot etməyi seçin.

### 3. Disk Bölmələri
NixOS qurulumundan əvvəl diskinizi uyğun şəkildə bölməlisiniz. Məsələn, `fdisk` və ya `parted` istifadə edərək disk bölməsini edə bilərsiniz. Aşağıda əsas bir bölmə nümunəsi verilmişdir:

```bash
# Diskləri yoxlayın
lsblk

# Disk bölməsi edin
fdisk /dev/sda
```

Məsələn, aşağıdakı kimi bir bölmə edə bilərsiniz:
- `/dev/sda1`: EFI (512MB, yalnız UEFI sistemləri üçün)
- `/dev/sda2`: Root bölməsi (məsələn 20GB+)

### 4. Fayl Sistemi Yaratma
Bölmələri yaratdıqdan sonra, bu bölmələrdə fayl sistemi yaratmalısınız:

```bash
# EFI bölməsi üçün fayl sistemi yaradın (əgər UEFI istifadə edirsinizsə)
mkfs.fat -F32 /dev/sda1

# Root bölməsi üçün ext4 fayl sistemi yaradın
mkfs.ext4 /dev/sda2
```

### 5. NixOS Qurulumuna Başlama
Diskinizə NixOS-u qurmaya başlamaq üçün aşağıdakı komandaları izləyə bilərsiniz:

```bash
# Root bölməsini bağlayın
mount /dev/sda2 /mnt

# EFI bölməsini bağlayın (yalnız UEFI istifadə edirsinizsə)
mount --target /mnt /dev/sda1
```

### 6. `nixos-generate-config` Komandasını İcra Edin
Qurulum fayllarınızı yaratmaq üçün `nixos-generate-config` komandasını işə salın:

```bash
nixos-generate-config --root /mnt
```

Bu komanda, `/mnt/etc/nixos/configuration.nix` faylını yaradacaq və bütün sistem parametrlərinizi bu faylda edə bilərsiniz.

### 7. Konfiqurasiya Faylını Düzəldin
`configuration.nix` faylını düzəltməlisiniz. `nano` və ya başqa bir mətn redaktoru ilə açıb, konfiqurasiyalarınızı edə bilərsiniz:

```bash
nano /mnt/etc/nixos/configuration.nix
```

Burada bunları etməlisiniz:
- İstifadəçi yaratma
- Şəbəkə konfiqurasiyası
- Paketlərin quraşdırılması
- Sistem dil və vaxt qurğusu ayarları

### 8. Qurulumu Tamamlama
Qurulum tamamlandıqdan sonra NixOS-u quraşdırmaq üçün aşağıdakı komandanı işlədin:

```bash
nixos-install
```

Qurulum bitdikdən sonra kompüterinizi yenidən başladın:

```bash
reboot
```

### 9. İlk Başlatma
Kompüteriniz yenidən başladığında, NixOS sisteminizin quraşdırıldığını və konfiqurasiyanızın düzgün şəkildə yükləndiyini görməlisiniz.

Bu addımlar, əsas NixOS qurulumu üçün nəzərdə tutulmuşdur. NixOS-un təklif etdiyi çoxsaylı xüsusiyyətlər və konfiqurasiyalar olduğundan, detallı xüsusiyyətlərə görə qurulumunuzu özəlleştirə bilərsiniz.# NixOsConf
