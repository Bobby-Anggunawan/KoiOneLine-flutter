Library ini berisi kumpulan widget dan fungsi fungsi untuk membantu pengembangan aplikasi dengan flutter. Fungsi fungsi dan widget dalam library ini dirancang agar dapat digunakan dengan mudah, hanya dengan memanggil satu baris kode.

## Features
- tambah gambar contoh extension
- tambah gambar rensponsive
- tambah gambar beberapa widget di sini
- tambah gambar beberapa library yang ada


## Getting started
Library ini terdiri dari beberapa modul antara lain:
- **extension**: untuk menambah fungsionalitas dari class class bawaan dart dann flutter.
- **widget**: berisi daftar widget yang mungkin berguna.
- **page**: kumpulan halaman yang siap digunakan, tinggal inject dengan informasi yang ingin ditampilkan.
- **lib**: kumpulan fungsi fungsi untuk membantu pengembangan perangkat lunak.
- **app**: kumpulan widget dan fungsi untuk membentuk kerangka aplikasi dan mengatur config aplikasi, dari routing, lokalisasi, ui responsive, dll.

Sebelum menggunakan library ini, sebaiknya anda menginisialisasi project dengan class `KoiApp` di fungsi `main()` dalam file `main.dart` project anda. Class ini sudah memuat kerangka kerangka dasar yang diperlukan untuk membuat aplikasi seperti routing. Untuk melakukannya, anda dapat menghapus semua isi file `main.dart` lalu memasukkan kode ini:
```dart
void main() {
  runApp(
      KoiApp(
          routes: KoiAppRoute
              .baseRoute(
            // init page that will be shown right after user open your app
            // you can use your own widget here, usually as splash screen
            // but here, we will be using default splash screen from this library: KoiPgSplash
              KoiPgSplash.redirectAfterFunction(
                  initialization: Future<bool>(()async{
                    // you can wrote your own code here to initialized your app before user open it.
                    // for example you want to check user login or not
                    // then you open login page if user not login
                    // or you open home page if user login.
                    // in this example, i just simply wait for 3 second before open home page.
                    await Future.delayed(Duration(seconds: 3));

                    //if return false, splash will not redirrect to home page
                    return true;
                  }),
                  // redirect to this page after initialization finish.
                  // makes sure you register this route using addRoutes("/home", Test())
                  redirectTo: "/home"
              )
          )
          // all other pahes your app have
              .addRoutes("/home", Test())
              .addRoutes("/otherPage1", OtherPage1())
              .addRoutes("/otherPage2", OtherPage2())
              .addRoutes("/otherPage3", OtherPage3()),
          // build your own theme color here using ThemeColor class
          themeColor: ThemeColor.autoGenerateFromColor(Colors.blue)
      )
  );
}
```

Sebenarnya langkah ini optional. Tapi jika anda melakukannya, anda dapat menggunakan beberapa fungsi di library ini seperti `KoiApp.showToast("Pesan anda")` untuk menampilkan toast, dan `KoiApp.isLoading(true)` untuk menampilkan spinner jika ada proses data di latar belakang.

## Usage

TODO: Include short and useful examples for package users. Add longer examples  
to `/example` folder.

```dart  
const like = 'sample';  
```  

## Additional information

TODO: Tell users more about the package: where to find more information, how to  
contribute to the package, how to file issues, what response they can expect  
from the package authors, and more.

### Dependency
- [http](https://pub.dev/packages/http)

## TODO

- [ ] **KoiPgSplash**: buat default splash di `_DefaultSplash`


## Migration
- [ ] app: KoiLayoutVariation masuk atau tidak?
- [ ] widget: masih todo, belum ada yang masuk
- [x] page
- [x] extension
- [x] lib