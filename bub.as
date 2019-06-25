

var en: String; // 英文名，同加载图片名
var cn: String; // 要显示的中文名

var rt: Number; // 最终半径

var val: Number;
var r: Number; // 实时半径=sqrt(val)

var vx: Number = Math.random() - 0.5; // 速度
var vy: Number = Math.random() - 0.5;
var v: Number; // 标量
var ax: Number = 0; // 加速度
var ay: Number = 0; // 加速度
var a: Number; // 标量

var par: Bub; // 登记一个包含者,在Acon里的层号

var Bcon: Sprite = new Sprite(); // container of single bubble
addChildAt(Bcon,0);


// import fl.controls.*;
// import fl.managers.StyleManager;

function initialize(xi: Number, yi: Number, eni: String, ri: Number, cni: String): void {

  this.x = xi;
  this.y = yi;

  r = ri;
  rt = 50;

  cn = cni;
  cname1.text = cni;
  cname1.y = 0.15 * rt;
  cname1.width = 2 * rt;
  //var form:TextFormat = new TextFormat();
  //form.size = rt/4;
  //cname1.setStyle("textFormat",format);
  cname1.scaleX=rt/48;
  cname1.scaleY=cname1.scaleX;
  cname1.x = - rt*cname1.scaleX;

  en = clearDelimeters(eni);
  this.name = en;
  var icon: Loader = new Loader();
  icon.contentLoaderInfo.addEventListener(Event.COMPLETE, iconLoaded);
  icon.load(new URLRequest(en + ".png"));
}


function iconLoaded(e: Event): void {

  var image: Bitmap = new Bitmap(e.target.content.bitmapData);
  image.width = 2 * rt;
  image.height = 2 * rt;
  image.x = -rt;
  image.y = -rt;

  // Create the mask graphic
  var maskCircle: Sprite = new Sprite();
  maskCircle.graphics.beginFill(0x000000);
  maskCircle.graphics.drawEllipse(-rt, -rt, 2 * rt, 2 * rt);
  maskCircle.graphics.endFill();
  maskCircle.visible = false;
  addChild(maskCircle);

  Bcon.mask = maskCircle; // Applies the mask
  Bcon.addChildAt(image, 0);

  var rect: Sprite = new Sprite();
  rect.graphics.beginFill(0x000000);
  rect.graphics.drawRect(-rt, 0.26 * rt, 2 * rt, rt);
  rect.graphics.endFill();
  rect.alpha = 0.5;
  // rect.mask = maskCircle;
  Bcon.addChild(rect);

  var bCircle: Sprite = new Sprite(); // 描边
  bCircle.graphics.beginFill(0xffffff);
  bCircle.graphics.drawEllipse(-1.03*rt,-1.03*rt, 2.06 * rt, 2.06 * rt);
  bCircle.graphics.endFill();
  bCircle.alpha = 0.5;
  addChildAt(bCircle, 0);
}



function pw(f: Number): Number {
  return(f * f)
}




function updatepar(): void {
  if(par != null){par.val+=val;}
}



function updatepos(total:int): void {

  cname1.text = val.toString()+"\n"+(val/total*100).toFixed(1).toString()+"%";
  //r = Math.sqrt(val);
  r = val;

  if(r>0.1){
    this.scaleX += (r/2/this.width-this.scaleX)/4; //缓冲放大
    this.scaleY = this.scaleX;
  }else{
    this.scaleX = 0.01;
    this.scaleY = this.scaleX;
  }

  if(par != null){topar()}
  /*a = pw(ax) + pw(ay);
  if(a > 4) { // 限制最大加速度2
    a = Math.sqrt(4 / a);
    ax = ax * a;
    ay = ay * a;
  }*/
  vx += ax;
  vy += ay*0.5; // 让泡泡更易往左右跑而不是上下跑
  ax = 0;
  ay = 0;

  v = pw(vx) + pw(vy);
  /*if(v > 9) { // 限制最大速度3
    a = Math.sqrt(9 / v); // 借用下变量a...
    vx = vx * a;
    vy = vy * a;
  }*/
  if(v >= 0.1) { // 速度衰减
    vx = vx*0.8;
    vy = vy*0.8;
  } else { // 长期微小移动很影响画质和性能
    vx = 0;
    vy = 0;
  }

  this.x += vx;
  this.y += vy;
}



function topar(): void { // 向包含对象吸引

  ax -= (this.x-par.x)/60;
  ay -= (this.y-par.y)/50;
}



function clearDelimeters(formattedString: String): String {
  return formattedString.replace(/[\u000d\u000a\u0008\u0020]+/g, "");
}