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
- **design_pattern**: kumpulan base class untuk menggunakan design pattern

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

### Design Pattern

Design Pattern gave structure to your code so it makes you easier to read and maintenance it. Actualy you just need a few line to wrote it, but it annoying to keep wrote this code over and over again when working on new project 😌. Thats why i put design pattern here as one submodule of this package 👍.

#### Chain of Responsibility

Use this design pattern when you have chain of process that need to run one by one in order. For example like buying thing at online store, theres chain of process you need to do before you finally get your product from inserting product to cart, then chose payment, and then pay.

So it like **Do this function** and after then **Do those function** and then **Do other function** and so on..

##### Example
This example create chain of responsibility with 2 handler and store it in `createChain`. And then we run `createChain` by calling `run()` and pass `1` as parameter. The output of this chain are `3` because in each handler, parameter are added by 1 and theres 2 handler there.

**Note** you can use async or normal function in each handler.. Make sure to use `await` when using async function 😉

```dart
Future<int> asyncAdd(int data)async{
  await Future.delayed(
    const Duration(seconds: 1),
        (){},
  );
  return data+1;
}

int add(int data){
  return data+1;
}

void main() {
  var createChain = ChainOfResponsibility<int>(
      handle: (data) => asyncAdd(data),
      nextHandler: ChainOfResponsibility<int>(
          handle: (data) => add(data),
          nextHandler: null
      )
  );

  createChain.run(1, passToNextHandler: true).then((data){
    print(data);
  });
}
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to  
contribute to the package, how to file issues, what response they can expect  
from the package authors, and more.

### Dependency
- [http](https://pub.dev/packages/http)
- [infinite_scroll_pagination ](https://pub.dev/packages/infinite_scroll_pagination)

## TODO

- [ ] **KoiPgSplash**: buat default splash di `_DefaultSplash`


## Migration
- [ ] app: KoiLayoutVariation masuk atau tidak?
- [ ] widget: masih todo, belum ada yang masuk
- [x] page
- [x] extension
- [x] lib