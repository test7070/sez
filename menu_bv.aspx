<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			$(document).ready(function() {
				q_getId();
				q_gf('', 'menu_bv');
			});

			var t_permit;
			var r_rank = '9';
			function q_gfPost() {
				document.title = '全速配托運資訊系統';
				$('#userno').text(r_userno);
				$('#rname').text(r_name);
				
				
				$('.leftbox a').each(function() {
					child = $(this).attr('id');
					//權限id EX:特殊判斷 tboatcs用tboat的權限
					auth_child = $(this).attr('id');
					auth_child=(auth_child=='tboatcs'?'tboat':auth_child)
					
					//取得讀取權限
					var t_permit=false;
					if (auth_child) {
						for (var i = 0; i < q_auth.length; i++){
							if (auth_child == q_auth[i].substr(0, auth_child.length)) {
								t_permit = q_auth[i].substr(auth_child.length + 1, 1) == '1' ? true : false;
								break;
							}
						}
					}
					
					//外部廠商開放的網頁id
					var outs_aspx=['tboat'];
					
					//處理開放網頁
					if(child!='download'){
						if(r_outs==1){//外部廠商
							if(outs_aspx.indexOf(child)>-1 && t_permit){//有在開放的網頁 且有權限
								$(this).click(function() {
									window.open($(this).attr('class')+".aspx?"+q_getId()[0]+";"+q_getId()[1]+";"+q_getId()[2]+";;"+q_getId()[4]);
								});
							}else{
								$(this).css('cursor','auto').css('color','rgb(200,200,200)').css('text-decoration','none');
							}
						}else{//正常帳號
							if (r_rank < 8 && !t_permit){ //沒有執行權限
								$(this).css('cursor','auto').css('color','rgb(200,200,200)').css('text-decoration','none');
							}else{//有權限
								$(this).click(function() {
									window.open($(this).attr('class')+".aspx?"+q_getId()[0]+";"+q_getId()[1]+";"+q_getId()[2]+";;"+q_getId()[4]);
								});
							}
						}
					}
				});

			}

			function q_gtPost(t_name) {
				switch (t_name) {

				}
			}

			function q_boxClose(s2) {
			}
		</script>
		<style type="text/css">
			.leftbox {
				float: left;
				width: 400px;
				/*padding:15px 30px;*/
			}
			.righttbox {
				float: left;
				width: 800px;
				/*padding:15px 30px;*/
			}
			
			ol {
			  list-style-type: none;
			  counter-reset: item;
			  margin: 0;
			  padding: 0.3em;
			  margin-left: 1em;
			}
			
			ol > li {
			  display: table;
			  counter-increment: item;
			  margin-bottom: 0.6em;
			}
			
			ol > li:before {
			  content: counters(item, ".") ". ";
			  display: table-cell;
			  padding-right: 0.6em;    
			}
			
			li ol > li {
			  margin: 0;
			}
			
			li ol > li:before {
			  content: counters(item, ".") " ";
			}
			
			.leftbox a{
				cursor: pointer;
				color: #0300FA;
				text-decoration:underline;
			}
			
			.leftbox a:hover { 
			    color: #FA0300;
			}

		</style>
	</head>
	<body>
		<div style="width:1250px;height: 800px;">
			<div style="width:1250px;height: 100px;">
				標題
			</div>
			<div class="leftbox" style="height: 700px;">
				<ol>
					<li>基本資料主檔
						<ol>
							<li><a id="cust" class="cust_bv">客戶資料</a></li>
							<li><a id="addr2" class="addr2_bv">行政區配送維護</a></li>
							<li><a id="addr3" class="addr3_bv">發送所簡碼維護</a></li>
							<li><a id="sss" class="sss">客戶資料</a></li>
						</ol>
					</li>
					<li>預購系統
						<ol>
							<li><a id="tranorde" class="tranorde_bv">預購作業</a></li>
							<li><a id="z_trans_bv" class="z_trans_bv">使用情況控管表</a></li>
						</ol>
					</li>
					<li>手寫託運單作業
						<ol>
							<li><a id="transef_hand_bv" class="transef_hand_bv">手寫單總表</a></li>
							<li><a id="z_tranorde_bv" class="z_tranorde_bv">手寫託運單套表列印(補印用)</a></li>
							<li><a id="tboat2" class="tboat2_bv">轉聯運作業</a></li>
						</ol>
					</li>
					<li>EDI託運單作業
						<ol>
							<li><a id="uploaddc" class="uploadbv">EDI資料上傳</a></li>
							<li><a id="transef_edi_bv" class="transef_edi_bv">EDI上傳總表</a></li>
							<li><a id="z_transef_bv" class="z_transef_bv">EDI託運單列印</a></li>
						</ol>
					</li>
					<li>派遣作業
						<ol>
							<li><a id="tboat" class="tboat_bv">派遣作業_客戶</a></li>
							<li><a id="tboatcs" class="tboatcs_bv">派遣作業_CS</a></li>
							<li><a id="z_tboat_bv" class="z_tboat_bv">派遣控管表</a></li>
						</ol>
					</li>
					<li>查詢作業
						<ol>
							<li><a id="z_transef_seek_bv" class="z_transef_seek_bv">寄收狀況查詢</a></li>
						</ol>
					</li>
					<li>其他工具程式
						<ol>
							<li><a id="nhpe" class="nhpe">員工密碼設定</a></li>
							<li><a id="z_drun" class="z_drun">使用紀錄查詢</a></li>
							<li><a id="download" href="http://59.125/143.170/g.exe">連線程式下載</a></li>
						</ol>
					</li>
				</ol>
			</div>
			<div class="righttbox top" style="height:80%;">
			</div>
			<div class="righttbox bottom" style="height:20%;text-align: right">
				<table style="float: right;">
					<tr align="right">
						<td  align="center"><a id="userno"> </a></td>
						<td  align="center"><a id="rname"> </a></td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>


