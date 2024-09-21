import 'dart:io';

// Struktur untuk menyimpan data hijab
class Hijab {
  String name; // Nama Hijab
  String jenis; // Jenis Kain
  double price; // Harga Hijab
  int stock; // Jumlah Stok
  Supplier? supplier; // Referensi ke supplier hijab

  Hijab(this.name, this.jenis, this.price, this.stock, [this.supplier]);

  @override
  String toString() {
    String supplierInfo =
        supplier != null ? " | Supplier: ${supplier!.name}" : "";
    return "$name ($jenis) - Rp$price | Stok: $stock$supplierInfo";
  }
}

// Kelas untuk menyimpan informasi pemasok
class Supplier {
  String name; // Nama Pemasok
  String contact; // Kontak Pemasok

  Supplier(this.name, this.contact);

  @override
  String toString() {
    return "$name | Kontak: $contact";
  }
}

// Daftar untuk menyimpan data hijab
List<Hijab> hijabs = [];
List<Supplier> suppliers = [];

void main() {
  while (true) {
    clearScreen();
    print("===================");
    print("Aplikasi Toko Hijab");
    print("===================");
    print("1. Tambah Hijab");
    print("2. Tambah Supplier");
    print("3. Lihat Daftar Hijab");
    print("4. Lihat Daftar Supplier");
    print("5. Ubah Data Hijab");
    print("6. Hapus Hijab");
    print("7. Keluar");
    stdout.write("Pilih: ");

    String? pilihan = stdin.readLineSync();
    switch (pilihan) {
      case "1":
        tambahHijab();
        pause();
        break;
      case "2":
        tambahSupplier();
        pause();
        break;
      case "3":
        lihatHijab();
        pause();
        break;
      case "4":
        lihatSupplier();
        pause();
        break;
      case "5":
        ubahHijab();
        pause();
        break;
      case "6":
        hapusHijab();
        pause();
        break;
      case "7":
        exit(0);
      default:
        print("Pilihan tidak valid.");
    }
  }
}

void tambahHijab() {
  stdout.write("Masukkan Nama Hijab: ");
  String? name = stdin.readLineSync();

  stdout.write("Masukkan Jenis Kain: ");
  String? jenis = stdin.readLineSync();

  stdout.write("Masukkan Harga (Rp): ");
  double? price = double.tryParse(stdin.readLineSync() ?? '');

  stdout.write("Masukkan Stok: ");
  int? stock = int.tryParse(stdin.readLineSync() ?? '');

  // Menampilkan daftar supplier
  lihatSupplier();
  stdout.write("Pilih nomor supplier (atau tekan Enter jika tidak ada): ");
  String? supplierIndexStr = stdin.readLineSync();
  Supplier? supplier;
  if (supplierIndexStr != null && supplierIndexStr.isNotEmpty) {
    int supplierIndex = int.tryParse(supplierIndexStr) ?? -1;
    if (supplierIndex > 0 && supplierIndex <= suppliers.length) {
      supplier = suppliers[supplierIndex - 1];
    }
  }

  if (name != null && jenis != null && price != null && stock != null) {
    hijabs.add(Hijab(name, jenis, price, stock, supplier));
    print("$name berhasil ditambahkan ke daftar hijab!");
  } else {
    print("Input tidak valid, mohon coba lagi.");
  }
}

void tambahSupplier() {
  stdout.write("Masukkan Nama Supplier: ");
  String? name = stdin.readLineSync();

  stdout.write("Masukkan Kontak Supplier: ");
  String? contact = stdin.readLineSync();

  if (name != null && contact != null) {
    suppliers.add(Supplier(name, contact));
    print("$name berhasil ditambahkan ke daftar supplier!");
  } else {
    print("Input tidak valid, mohon coba lagi.");
  }
}

void lihatHijab() {
  if (hijabs.isEmpty) {
    print("Belum ada hijab yang ditambahkan.");
  } else {
    // Menampilkan header tabel
    print("Daftar Hijab:");
    print(
        "+-----+--------------------+--------------------+---------+-------+");
    print(
        "| No. | Nama               | Jenis Kain         | Harga   | Stok  |");
    print(
        "+-----+--------------------+--------------------+---------+-------+");

    // Menampilkan data hijab dalam tabel
    for (int i = 0; i < hijabs.length; i++) {
      Hijab hijab = hijabs[i];
      print(
          "| ${i + 1}   | ${hijab.name.padRight(18)} | ${hijab.jenis.padRight(18)} | Rp${hijab.price.toString().padRight(7)} | ${hijab.stock.toString().padRight(5)} |");
    }

    // Menampilkan footer tabel
    print(
        "+-----+--------------------+--------------------+---------+-------+");
  }
}

void lihatSupplier() {
  if (suppliers.isEmpty) {
    print("Belum ada supplier yang ditambahkan.");
  } else {
    print("Daftar Supplier:");
    print("+-----+--------------------+--------------------+");
    print("| No. | Nama               | Kontak             |");
    print("+-----+--------------------+--------------------+");

    // print data supplier dalam tabel
    for (int i = 0; i < suppliers.length; i++) {
      Supplier supplier = suppliers[i];
      print(
          "| ${i + 1}   | ${supplier.name.padRight(18)} | ${supplier.contact.padRight(18)} |");
    }
    print("+-----+--------------------+--------------------+");
  }
}

void ubahHijab() {
  if (hijabs.isEmpty) {
    print("Belum ada hijab yang bisa diubah.");
    return;
  }

  lihatHijab();
  stdout.write("Masukkan nomor hijab yang ingin diubah: ");
  int? index = int.tryParse(stdin.readLineSync() ?? '');

  if (index != null && index > 0 && index <= hijabs.length) {
    stdout.write("Masukkan Nama Hijab Baru: ");
    String? name = stdin.readLineSync();

    stdout.write("Masukkan Jenis Kain Baru: ");
    String? jenis = stdin.readLineSync();

    stdout.write("Masukkan Harga Baru (Rp): ");
    double? price = double.tryParse(stdin.readLineSync() ?? '');

    stdout.write("Masukkan Stok Baru: ");
    int? stock = int.tryParse(stdin.readLineSync() ?? '');

    if (name != null && jenis != null && price != null && stock != null) {
      hijabs[index - 1] = Hijab(name, jenis, price, stock);
      print("Data hijab berhasil diubah!");
    } else {
      print("Input tidak valid, mohon coba lagi.");
    }
  } else {
    print("Nomor hijab tidak valid.");
  }
}

void hapusHijab() {
  if (hijabs.isEmpty) {
    print("Belum ada hijab yang bisa dihapus.");
    return;
  }

  lihatHijab();
  stdout.write("Masukkan nomor hijab yang ingin dihapus: ");
  int? index = int.tryParse(stdin.readLineSync() ?? '');

  if (index != null && index > 0 && index <= hijabs.length) {
    Hijab hijabHapus = hijabs.removeAt(index - 1);
    print("${hijabHapus.name} berhasil dihapus dari daftar.");
  } else {
    print("Nomor hijab tidak valid.");
  }
}

void clearScreen() {
  // Mencetak beberapa baris kosong
  print("\x1B[2J\x1B[0;0H"); // Menggunakan escape code ANSI
}

void pause() {
  print("\nTekan Enter untuk melanjutkan...");
  stdin.readLineSync(); // Menunggu input pengguna
}
