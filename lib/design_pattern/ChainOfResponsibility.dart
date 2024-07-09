class ChainOfResponsibility<T>{
  ChainOfResponsibility({required this.handle, required this.nextHandler});

  ChainOfResponsibility<T>? nextHandler;

  /// fungsi yang digunakan untuk menghandle request
  Function(dynamic data) handle;

  /// kalau processData = true, berarti parameter akan diubah tiap di pass ke handler menjadi hasil return dari fungsi [handle]
  /// jadi kalau processData = false, berarti, parameter data tidak akan diubah akan terus sama untuk semua handler di chain
  T? run(dynamic data, {bool processData = false}){
    if(nextHandler != null){
      if(processData){
        data = handle(data);
      }
      else{
        handle(data);
      }
      return nextHandler!.run(data, processData: processData);
    }
    else{
      return handle(data);
    }
  }
}