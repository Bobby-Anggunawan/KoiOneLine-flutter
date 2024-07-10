/*
* butuh cara untuk memastikan Chain di pass antar halaman
	*pass aja handler ke parameter screen baru
dan di tiap halaman, harus di trigger fungsi handle-nya yng aka menghandle request dan membuka handler baru
	*berarti jangan jalankan fungsi run.. jalankan fungsi handle aja
	*terus setelah handle selesai, pass next handler ke halaman selanjutnya
* */

/// design pattern ChainOfResponsibility
class ChainOfResponsibility<T>{
  ChainOfResponsibility({required this.handle, required this.nextHandler});

  ChainOfResponsibility<T>? nextHandler;

  /// fungsi yang digunakan untuk menghandle request
  Function(dynamic data) handle;

  /// kalau passToNextHandler = true, berarti parameter akan diubah tiap di pass ke handler menjadi hasil return dari fungsi [handle]
  /// jadi kalau passToNextHandler = false, berarti, parameter data tidak akan diubah akan terus sama untuk semua handler di chain
  Future<T?> run(dynamic data, {bool passToNextHandler = false})async{
    if(nextHandler != null){
      if(passToNextHandler){
        data = await handle(data);
      }
      else{
        await handle(data);
      }
      return await nextHandler!.run(data, passToNextHandler: passToNextHandler);
    }
    else{
      return await handle(data);
    }
  }
}