stop();
var fps: int = 6;
stage.frameRate = fps;
stage.quality = "best";

savefont.visible = false; //用来嵌入字体的

import flash.display.*;
import flash.text.*;
import flash.events.*;
import flash.net.*;


var i: int;
var j: int;
var t: int;
var tim: Number;









// 以下是 AutoAni 柱图照搬

var loadcfg: URLLoader = new URLLoader();
loadcfg.dataFormat = URLLoaderDataFormat.TEXT;
loadcfg.addEventListener(Event.COMPLETE, cfgLoaded);
loadcfg.load(new URLRequest("config.csv"));

var cfg: Array;
var fp: int;

function cfgLoaded(evt: Event): void {

  cfg = loadcfg.data.split("\n");
  for (i = 0; i < cfg.length; i++) {
    cfg[i] = cfg[i].split(",");
  }

  stage.color = cfg[2][0];

  stage.frameRate = int(cfg[5][0]);
  fp = cfg[6][0]; // 几帧过一个数据

  RKcon.x = cfg[20][0];
  RKcon.y = cfg[21][0];

}

var rk: rankBar;
var RKcon: Sprite = new Sprite(); // RankBar 容器










var loader: URLLoader = new URLLoader();
loader.dataFormat = URLLoaderDataFormat.TEXT;
loader.addEventListener(Event.COMPLETE, dataLoaded);
loader.load(new URLRequest("data.csv"));

var da: Array;
var Num: int;
var bu: Bub;
var pofix: String; // 所加载图片的后缀

var Acon: Sprite = new Sprite(); // container of all bubble
Acon.x = 1920 / 2;
Acon.y = 1080 / 2;
addChild(Acon);

  addChild(RKcon);

var grid: Grid = new Grid();
grid.x = Acon.x;
grid.y = Acon.y;
addChildAt(grid, 0);

function dataLoaded(evt: Event): void {

	da = loader.data.split("\n");
	for (i = 0; i < da.length; i++) {
		da[i] = da[i].split(",");
	}

	// 从第3行第1列开始过滤非数字
	for (i = 2; i < da.length; i++) {
		for (j = 1; j < da[i].length; j++) {
			da[i][j] = Number(da[i][j]);
			if (isNaN(da[i][j])) {
				da[i][j] = 0;
			}
		}
	}

	pofix = da[0][0];
	Num = da[0].length - 1; // 计算条目数
	trace(Num)

	for (i = 0; i < Num; i++) {
		bu = new Bub();
		bu.initialize(da[2][i + 1], da[3][i + 1], da[0][i + 1], da[5][i + 1], da[0][i + 1]);
		Acon.addChildAt(bu, i);
	}
	for (i = 0; i < Num; i++) {
		bu = Acon.getChildAt(i) as Bub;
		if (da[4][i + 1] >= 0) {
			bu.par = Acon.getChildAt(int(da[4][i + 1])) as Bub;
		}
	}
	tim = 6;

	stage.addEventListener(Event.ENTER_FRAME, movie);
	stage.frameRate = 0;

	//this.x = Cx(t);
	//this.y = Cy(t);
	fadespeed = 64;
	fadeinscale = 6;
	Acon.addEventListener(Event.ENTER_FRAME, fadein);


	for (i = 0; i < Num; i++) {
		rk = new rankBar();
		rk.initialize(i + 1, da[0][i + 1], da[0][i + 1], da[1][i + 1], ".png", cfg);
		RKcon.addChildAt(rk, i);
	}
}



var bt1: Bub;
var bt2: Bub;
var total: int;

function movie(event: Event): void {
	tim += 1 / fp;
	t = int(tim);
	if (t > 3674) {
		t = 3674
	}
	total = (da[t][1] + da[t][2] + da[t][3] + da[t][4] + da[t][5] + da[t][6] + da[t][7] + da[t][8] + da[t][9] + da[t][10] + da[t][11] + da[t][12] + da[t][13] + da[t][14] + da[t][15]);
	//timer.text=da[t][0]+"\n 总投稿数 "+total.toString()+"\n"+t.toString()+" 帧";
	timer.text = da[t][0];
	setChildIndex(timer, numChildren - 1);

	if (da[t][0] == "2010年01月01日") {
		(Acon.getChildByName("番剧") as Bub).par = null;
		(Acon.getChildByName("国创") as Bub).par = (Acon.getChildByName("番剧") as Bub);
	}
	if (da[t][0] == "2012年06月09日") {
		(Acon.getChildByName("科技") as Bub).par = null;
		(Acon.getChildByName("数码") as Bub).par = (Acon.getChildByName("科技") as Bub);
	}
	if (da[t][0] == "2013年11月11日") {
		(Acon.getChildByName("影视") as Bub).par = null;
		(Acon.getChildByName("放映厅") as Bub).par = (Acon.getChildByName("影视") as Bub);
	}
	if (da[t][0] == "2014年09月04日") {
		(Acon.getChildByName("舞蹈") as Bub).par = null;
		(Acon.getChildByName("鬼畜") as Bub).par = null;
	}
	if (da[t][0] == "2015年12月02日") {
		(Acon.getChildByName("时尚") as Bub).par = null;
	}
	if (da[t][0] == "2016年06月16日") {
		bt1 = Acon.getChildByName("生活") as Bub;
		bt1.par = null;
		bt1.y += 200;
	}
	if (da[t][0] == "2016年08月16日") {
		(Acon.getChildByName("广告") as Bub).par = null;
	}
	if (da[t][0] == "2017年03月23日") {
		bt1 = Acon.getChildByName("国创") as Bub;
		bt1.par = null;
		bt1.x -= 200;
		bt1.y -= 200;
	}
	if (da[t][0] == "2017年10月23日") {
		bt1 = Acon.getChildByName("放映厅") as Bub;
		bt1.par = null;
		bt1.x -= 1500;
		bt1.y -= 1500;
	}
	if (da[t][0] == "2019年01月03日") {
		bt1 = Acon.getChildByName("数码") as Bub;
		bt1.par = null;
		bt1.x -= 2000; // 气泡太大，需加快分离
		bt1.y -= 2000;
	}


	//trace("contain.numChildren=" + Acon.numChildren);

	for (i = 0; i < Acon.numChildren; i++) {
		bt1 = Acon.getChildAt(i) as Bub;
		bt1.val = da[t][i + 1];
	}
	for (i = 0; i < Acon.numChildren; i++) {
		bt1 = Acon.getChildAt(i) as Bub;
		bt1.updatepar(); // 必须分三轮计算
	}
	for (i = 0; i < Acon.numChildren; i++) {
		bt1 = Acon.getChildAt(i) as Bub;
		bt1.updatepos(total);
	}


	for (i = 0; i < Acon.numChildren; i++) {
		bt1 = Acon.getChildAt(i) as Bub;
		//toCenter(bt1);
		for (j = i + 1; j < Acon.numChildren; j++) {
			bt2 = Acon.getChildAt(j) as Bub;
			check(bt1, bt2);
			//trace("checkij:"+i+","+j);
		}
	}

	/*if (t >= 2000) {
    stage.removeEventListener(Event.ENTER_FRAME, movie);
  }*/
	rkmovie();
}







// debug
/*for (i = 0; i < Br.length; i++) {
  var btmp: Bub;
  btmp = contain.getChildAt(i) as Bub;
  trace(i + "层是：" + btmp.en + "，r=" + btmp.r);
}
trace("numChildren="+contain.numChildren);*/


function pw(f: Number): Number {
	return (f * f)
}


function toCenter(b1: Bub): void { // 此力与距离无关
	//var r:Number = Math.sqrt(pw(b1.x)+pw(b1.y));
	b1.ax -= b1.x / 600; ///r
	b1.ay -= b1.y / 500;
}

function check(b1: Bub, b2: Bub): void {

	/*if(b1.x > b2.x - 2 * b2.width && b1.x < b2.x + 2 * b2.width && b1.y > b2.y - 2 * b2.height && b1.y < b2.y + 2 * b2.height){ // b2 比 b1 大，用 2*b2 的范围作预判以提高性能
  if(b1.hitTestObject(b2)) {
    repel(b1, b2);
  }*/


	//if(b1.x > b2.x - 2 * b2.rt && b1.x < b2.x + 2 * b2.rt && b1.y > b2.y - 2 * b2.rt && b1.y < b2.y + 2 * b2.rt) { // b2 比 b1 大，用 2*b2 的范围作预判以提高性能
	//if(b1.hitTestObject(b2)) {
	var d: Number = Math.sqrt(pw(b1.x - b2.x) + pw(b1.y - b2.y));
	var repel: Number = b1.r + b2.r;

	if (d <= 1) {
		b1.x += 2 * Math.random() - 1;
		b1.y += 2 * Math.random() - 1;
	} else if (b1.hitTestObject(b2) && checknotpar(b1, b2)) {
		var f: Number = (1 / d - 1 / repel) * 4;
		var fx: Number = (b1.x - b2.x) * f;
		var fy: Number = (b1.y - b2.y) * f;
		b1.ax += fx;
		b1.ay += fy;
		b2.ax -= fx;
		b2.ay -= fy;
	}

}


function checknotpar(b1: Bub, b2: Bub): Boolean {
	if (b1.par != null) {
		if (b1.par.en == b2.en) {
			return false
		}
	}
	if (b2.par != null) {
		if (b2.par.en == b1.en) {
			return false
		}
		if (b1.par != null) {
			if (b1.par.en == b2.par.en) {
				return false
			} // 有共同父母也不排斥
		}
	}
	return true
}

addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
function keyPressed(event: KeyboardEvent): void {

	if (event.keyCode == Keyboard.SPACE) {
		if (stage.frameRate <= 1) {
			stage.frameRate = int(cfg[5][0]);
		} else {
			stage.frameRate = 0;
		}
	}
	// 方向键控制柱子移动
	if (event.keyCode == Keyboard.RIGHT) {
    fadeupx = Acon.x - 10;
    Acon.addEventListener(Event.ENTER_FRAME, fadex);
	}
	if (event.keyCode == Keyboard.LEFT) {
    fadeupx = Acon.x + 10;
    Acon.addEventListener(Event.ENTER_FRAME, fadex);
	}
  if(event.keyCode == Keyboard.UP) {
    fadeupy = Acon.y - 10;
    Acon.addEventListener(Event.ENTER_FRAME, fadey);
  }
  if(event.keyCode == Keyboard.DOWN) {
    fadeupy = Acon.y + 10;
    Acon.addEventListener(Event.ENTER_FRAME, fadey);
  }
	if (event.keyCode == Keyboard.Q) {
		fadespeed = 32;
		fadeinscale = Acon.scaleX * 0.6;
		//trace("[fade="+fadeinscale+", start acon="+Acon.scaleX)
		Acon.addEventListener(Event.ENTER_FRAME, fadein);
	}
	if (event.keyCode == Keyboard.W) {
		fadespeed = 16;
		fadeinscale = Acon.scaleX / 0.6;
		Acon.addEventListener(Event.ENTER_FRAME, fadein);
	}
}


var fadeinscale: Number = 0;
var fadespeed: Number;

function fadein(event: Event): void {

	Acon.scaleX -= (Acon.scaleX - fadeinscale) / fadespeed;
	syncSca();

	if (Math.abs(fadeinscale - Acon.scaleX) < fadeinscale * 0.001) {
		trace(fadeinscale + " removed " + Acon.scaleX)
		fadeinscale = 0;
		event.target.removeEventListener(Event.ENTER_FRAME, fadein);
	}
}

function syncSca(): void {
	Acon.scaleY = Acon.scaleX;
	grid.scaleX = Acon.scaleX * 8;
	grid.scaleY = Acon.scaleX * 8;
}



var fadeupx:Number = 0;
var fadeupy:Number = 0;

function fadey(event: Event): void {

  Acon.y -= (Acon.y-fadeupy)/2;

  if(Math.abs(Acon.y-fadeupy)<1){
    Acon.y = fadeupy;
    event.target.removeEventListener(Event.ENTER_FRAME, fadey);
  }
}
function fadex(event: Event): void {

  Acon.x -= (Acon.x-fadeupx)/2;

  if(Math.abs(Acon.x-fadeupx)<1){
    Acon.x = fadeupx;
    event.target.removeEventListener(Event.ENTER_FRAME, fadex);
  }
}





// 以下是 AutoAni 柱图照搬

var T: int = 2; // 数据从第4行开始
var tres: int = 0;

var bar1: rankBar;
var bar2: rankBar;

var po: Number = 0.0001; // population

var maxr: Number; // 计算缩放率用
var maxfan: Number; // 只缩不放用
var absmaxr: Number; // 兼容负数据用

var Tcon: Sprite = new Sprite(); // 冠军条容器
addChildAt(Tcon, 3);

var rect: Sprite = new Sprite();
Tcon.addChild(rect);

var lastid: String; // 更新冠军头像
var Icon: Sprite = new Sprite(); // 冠军头像容器
addChildAt(Icon, 0);

var bui: Bub;

function rkmovie(): void {

	if (t == 7) {
		// 解决某个 as 的 bug
		maxr = 0;
		absmaxr = 0;
		maxfan = 0;
		lastid = "2";

		//stage.frameRate = 0; // 启动时暂停
	}

	for (i = 0; i < RKcon.numChildren; i++) {
		rk = RKcon.getChildAt(i) as rankBar;
    bui = Acon.getChildByName(rk.cn) as Bub;
    if(bui.par!=null){
      rk.update(0);
    }else{
      rk.update(bui.val);
    }

	}

	var RKmax = RKcon.numChildren - 1;
	if (t % int(cfg[15][0]) == 1) { // 自定义每几帧更新次排序
		// 冒泡排序法（反转，最大的放最上层
		for (i = RKmax; i >= 0; i--) {
			bar1 = RKcon.getChildAt(i) as rankBar;

			for (j = i + 1; j <= RKmax; j++) {
				var bar2: rankBar = RKcon.getChildAt(j) as rankBar;
				if (bar1.fan > bar2.fan) {
					bar1.rank = RKmax - j;
				} else {
					break;
				}
			}
			RKcon.setChildIndex(bar1, RKmax - bar1.rank);
		}
	}


	// 可选宽度跟随第几名- int(cfg[75][1] - 1)
	bar1 = RKcon.getChildAt(RKmax) as rankBar;
trace(maxr);
	maxr += (Number(cfg[51][0]) / userfunc(bar1.fan, maxfan, cfg[53][0] == "1") - maxr) / Number(cfg[7][0]); // 加点缓冲
	if (Math.abs(maxfan) < Math.abs(bar1.fan)) {
		maxfan = bar1.fan;
	} else {
		maxfan += (bar1.fan - maxfan) * Number(cfg[54][0]); // 带缓冲地回缩
	}


	absmaxr = Math.abs(maxr);

	for (i = 0; i < RKcon.numChildren; i++) {
		bar1 = RKcon.getChildAt(i) as rankBar;
		bar1.rank = RKmax - i;
		bar1.updatey(bar1.rank, absmaxr); //bkggrid.scaleX
	}


	// 可选高亮第几名
	bar1 = RKcon.getChildAt(RKmax - int(cfg[75][0] - 1)) as rankBar;

	if (bar1.id != lastid && t > 2) {
		lastid = bar1.id;
	}
}



function userfunc(fan: Number, maxf: Number, iflog: Boolean): Number {
	var temp: Number;
	if (Math.abs(maxf) < Math.abs(fan)) {
		temp = fan;
	} else {
		temp = maxf;
	}
	if (iflog) {
		return (Math.log(1 + temp))
	} else {
		return (temp)
	}
}



function userheight(bar1: rankBar): Number {
	if (cfg[82][0] == "A") {
		return (bar1.fan / Number(cfg[82][1]))
	} else if (cfg[82][0] == "D") {
		return ((Number(da[T + int(cfg[82][2])][bar1.n]) - Number(da[T][bar1.n])) / Number(cfg[82][1]))
	} else {
		return (Number(cfg[82][0]))
	}
}