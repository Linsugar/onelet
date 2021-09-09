
import 'package:image_picker/image_picker.dart';

class Creamer{
 static ImagePicker _imagePicker = ImagePicker();

 static Future  GetCramer()async{
   try{
     var result = await  _imagePicker.getImage(source:ImageSource.camera);
     return result?.path;
   }catch(e){
     print("e:$e");
   }

  }
 static  Future GetGrally()async{
   try{
     var result =  await _imagePicker.getImage(source:ImageSource.gallery);

     return result?.path;
   }catch(e){
     print("e:$e");
   }

  }

}