class Userinfomodel{
  String ?name;
  String ?userid;
  String ?avator_image;
  Userinfomodel.fromMap(value){
    name = value['username'];
    userid = value['user_id'];
    avator_image = value['avator_image'];
  }
}

class wxinfo{
  String ?wxtitle;
  String ?wxauthor;
  String ?wxurl;
  String ?wxphoto;
  String ?wxdigest;
  wxinfo(value){
    this.wxtitle = value['title'];
    this.wxauthor = value['author'];
    this.wxurl = value['url'];
    this.wxphoto = value['thumb_url'];
    this.wxdigest = value['digest'];
  }

}


class VideoInfo{
  String ?videoCover;
  String ?videoTime;
  String ?videoUpUser;
  String ?videoUrl;
  String ?videoTitle;
  String ?videoContext;
  String ?video_id;

  VideoInfo(value){
    this.videoTitle = value['video_Title'];
    this.videoContext = value['video_Content'];
    this.videoUrl = value['video_url'];
    this.videoCover = value['video_Image'];
    this.videoTime = value['video_Time'];
    this.videoUpUser = value['video_User'];
    this.video_id = value['video_id'];
  }
}