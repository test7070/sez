<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
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
				
				
				$('.leftbox').children().each(function() {
					child = $(this).attr('id');
					if (child) {
						for (var i = 0; i < q_auth.length; i++)
							if (child == q_auth[i].substr(0, child.length)) {
								t_permit = q_auth[i].substr(child.length + 1, 1) == '1' ? true : false;

								break;
							}
					}
					if (r_rank < 8 && t_permit == 'false')
						$(this).removeAttr('href');

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
				list-style: none;
			}
			ol li span {
				display: block;
				float: left;
				width: 30px;
			}
			ol li {
				clear: both;
				width: 400px;
			}
			ol li p {
				float: left;
				width: 370px;
				margin: 0;
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
					<li>
						<span>1.</span>
						<p id='p1'>基本資料主檔</p>
					</li>
					<ol>
						<li>
							<span>1.1</span><a id='cust' href="cust_bv.aspx">客戶資料</a>
						</li>
						<li>
							<span>1.2</span><a id='addr2' href="addr2_bv.aspx">行政區配送維護</a>
						</li>
						<li>
							<span>1.3</span><a id='addr3' href="addr3_bv.aspx">發送所簡碼維護</a>
						</li>
					</ol>
					<li>
						<span>2.</span>
						<p id='p2'>預購系統</p>
					</li>
					<ol>
						<li>
							<span>2.1</span><a id='tranorde' href="tranorde_bv.aspx">預購作業</a>
						</li>
						<li>
							<span>2.2</span><a id='z_trans_bv' href="z_trans_bv.aspx">使用情況控管表</a>
						</li>
					</ol>
					<li>
						<span>3.</span>
						<p id='p3'>手寫託運單作業</p>
					</li>
					<ol>
						<li>
							<span>3.1</span><a id='transef_hand_bv' href="transef_hand_bv.aspx">手寫單總表</a>
						</li>
						<li>
							<span>3.2</span><a id='z_tranorde_bv' href="z_tranorde_bv.aspx">手寫託運單套表列印(補印用)</a>
						</li>
						<li>
							<span>3.3</span><a id='tboat2' href="tboat2_bv.aspx">轉聯運作業</a>
						</li>
					</ol>
					<li>
						<span>4.</span>
						<p id='p4'>EDI託運單作業</p>
					</li>
					<ol>
						<li>
							<span>4.1</span><a id='uploaddc' href="uploadbv.aspx">EDI資料上傳</a>
						</li>
						<li>
							<span>4.2</span><a id='transef_edi_bv' href="transef_edi_bv.aspx">EDI上傳總表</a>
						</li>
						<li>
							<span>4.3</span><a id='z_transef_bv' href="z_transef_bv.aspx">EDI託運單列印</a>
						</li>
					</ol>
					<li>
						<span>5.</span>
						<p id='p5'>派遣作業</p>
					</li>
					<ol>
						<li>
							<span>5.1</span><a id='tboat' href="tboat.aspx">派遣作業_客戶</a>
						</li>
						<li>
							<span>5.2</span><a id='trans' href="trans_bv.aspx">派遣作業_cs</a>
						</li>
						<li>
							<span>5.3</span><a id='z_tboat_bv' href="z_tboat_bv.aspx">派遣控管表</a>
						</li>
					</ol>
					<li>
						<span>6.</span>
						<p id='p6'>查詢作業</p>
					</li>
					<ol>
						<li>
							<span>6.1</span><a>寄收狀況查詢</a>
						</li>
					</ol>
					<li>
						<span>7.</span>
						<p id='p7'>其他工具程式</p>
					</li>
					<ol>
						<li>
							<span>7.1</span><a id='nhpe' href="nhpe.aspx">員工密碼設定</a>
						</li>
						<li>
							<span>7.2</span><a id='z_drun' href="z_drun.aspx">使用紀錄查詢</a>
						</li>
						<li>
							<span>7.3</span><a id='download' href="http://59.125/143.170/g.exe">連線程式下載</a>
						</li>
					</ol>
				</ol>
			</div>
			<div class="righttbox top" style="height:80%;">
			</div>
			<div class="righttbox bottom" style="height:20%;text-align: right">
				<table style="float: right;">
					<tr align="right">
						<td  align="center"><a id='userno'> </a></td>
						<td  align="center"><a id='rname'> </a></td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>

