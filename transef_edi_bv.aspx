<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">

			var q_name = "transef";
			
			aPop = new Array();
						
			function vcc() {
            }
            vcc.prototype = {
                data : null,
                tbCount : 10,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                lock : function(){
                    for(var i=0;i<this.tbCount;i++){
                        if($('#vcc_chk' + i).attr('disabled')!='disabled'){
                            $('#vcc_chk' + i).addClass('lock').attr('disabled', 'disabled');
                        }
                    }
                },
                unlock : function(){
                    for(var i=0;i<this.tbCount;i++){
                        if($('#vcc_chk' + i).hasClass('lock')){
                            $('#vcc_chk' + i).removeClass('lock').removeAttr('disabled');
                        }
                    }
                },
                load : function(){
                    var string = "<table id='vcc_table' style='width:1250px;'>";
                    string+='<tr id="vcc_header">';
                    string+='<td id="vcc_chk" align="center" style="width:20px; color:black;">選</td>';
                    string+='<td id="vcc_noa" onclick="vcc.sort(\'noa\',false)" title="上傳編號" align="center" style="width:120px; color:black;display:none;">上傳編號</td>';
                    string+='<td id="vcc_memo" onclick="vcc.sort(\'memo\',false)" title="上傳檔案" align="center" style="width:120px; color:black;">上傳檔案</td>';
                    string+='<td id="vcc_datea" onclick="vcc.sort(\'datea\',false)" title="上傳日期" align="center" style="width:80px; color:black;">上傳日期</td>';
                    string+='<td id="vcc_custno" onclick="vcc.sort(\'custno\',false)" title="客戶代號" align="center" style="width:150px; color:black;">客戶代號</td>';
                    string+='<td id="vcc_comp" onclick="vcc.sort(\'comp\',false)" title="客戶簡稱" align="center" style="width:150px; color:black;">客戶簡稱</td>';
                    string+='<td id="vcc_mount" onclick="vcc.sort(\'mount\',true)" title="筆數" align="center" style="width:100px; color:black;">筆數</td>';
                    string+='<td id="vcc_print" onclick="vcc.sort(\'mount\',true)" title="托運單" align="center" style="width:100px; color:black;">托運單</td>';
                    string+='</tr>';
                    
                    var t_color = ['DarkBlue','DarkRed'];
                    for(var i=0;i<this.tbCount;i++){
                        string+='<tr id="vcc_tr'+i+'">';
                        string+='<td style="text-align: center;"><input id="vcc_chk'+i+'" class="vcc_chk" type="checkbox"/></td>';
                        string+='<td id="vcc_noa'+i+'" style="text-align: center;display:none;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="vcc_memo'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="vcc_datea'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="vcc_custno'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="vcc_comp'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="vcc_mount'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="vcc_print'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='</tr>';
                    }
                    string+='</table>';
                    
                    $('#vcc').append(string);
                    string='';
                    string+='<a id="lblCust" style="float:left;">客戶編號</a><input id="textCustno"  type="text" style="float:left;width:130px;"/>';
                    string+='<a style="float:left;">上傳日期</a><input id="textBdate"  type="text" style="float:left;width:80px;"/><a style="float:left;">~</a><input id="textEdate"  type="text" style="float:left;width:80px;"/>';
                    string+='<input id="btnVcc_refresh"  type="button" style="float:left;width:100px;" value="查詢"/>';
                    string+='<input id="btnVcc_previous" onclick="vcc.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                    string+='<input id="btnVcc_next" onclick="vcc.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                    string+='<input id="textCurPage" onchange="vcc.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
                    string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                    string+='<input id="textTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#vcc_control').append(string);
                    
                    $('#textBdate').mask('999/99/99');
                    $('#textEdate').mask('999/99/99');
                    
                },
                init : function(obj) {
                    $('.vcc_chk').click(function(e) {
                        $(".vcc_chk").not(this).prop('checked', false);
                        $(".vcc_chk").not(this).parent().parent().find('td').css('background', 'pink');
                        $(this).prop('checked', true);
                        $(this).parent().parent().find('td').css('background', '#FF8800');
                        
                        //顯示BBS的資料
                        var n=$(this).attr('id').replace('vcc_chk','')
                        vcc_n=n;
                        var t_where="where=^^treno='"+$('#vcc_noa'+n).text()+"' ^^";
						q_gt('view_transef', t_where, 0, 0, 0,'show_transef', r_accy);
                        $('#transef').html('');
                    });
                    
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['noa'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textTotPage').val(this.totPage);
                    this.sort('noa', false);
                    Unlock();
                },
                sort : function(index, isFloat) {
                    //訂單排序
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[vcc.curIndex] == undefined ? "0" : a[vcc.curIndex]);
                            var n = parseFloat(b[vcc.curIndex] == undefined ? "0" : b[vcc.curIndex]);
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[vcc.curIndex] == undefined ? "" : a[vcc.curIndex];
                            var n = b[vcc.curIndex] == undefined ? "" : b[vcc.curIndex];
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else {
                                if (m < n)
                                    return 1;
                                if (m > n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage == this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                            $('#vcc_chk' + i).removeAttr('disabled');
                            $('#vcc_noa' + i).html(this.data[n+i]['noa']);
                            $('#vcc_memo' + i).html(this.data[n+i]['memo']);
                            $('#vcc_datea' + i).html(this.data[n+i]['datea']);
                            $('#vcc_custno' + i).html(this.data[n+i]['custno']);
                            $('#vcc_comp' + i).html(this.data[n+i]['comp']);
                            $('#vcc_mount' + i).html(this.data[n+i]['mount']);
                        } else {
                            $('#vcc_chk' + i).attr('disabled', 'disabled');
                            $('#vcc_noa' + i).html('');
                            $('#vcc_memo' + i).html('');
                            $('#vcc_datea' + i).html('');
                            $('#vcc_custno' + i).html('');
                            $('#vcc_comp' + i).html('');
                            $('#vcc_mount' + i).html('');
                        }
                    }
                    $('#vcc_chk0').click();
                    $('#vcc_chk0').prop('checked', 'true');
                }
            };
            vcc = new vcc();

			$(document).ready(function() {		
				_q_boxClose();
                q_getId();
                q_gf('', q_name);
                vcc.load();
			});
			
			function q_gfPost() {
				q_getFormat();
                q_langShow();
                q_popAssign();
                q_cur=2;
                document.title='EDI託運單總表';
                
                t_where="where=^^1=1 ^^";
				q_gt('view_vcc', t_where, 0, 0, 0,'aaa', r_accy);
                
                $('#btnVcc_refresh').click(function(e) {
                    var t_where = "1=1 ";
                    var t_custno = $('#textCustno').val();
                    var t_bdate = $('#textBdate').val();
                    var t_edate = $('#textEdate').val();
					t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
					t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .
                    
                    t_where += q_sqlPara2("custno", t_custno)+ q_sqlPara2("isnull(datea,'')", t_bdate,t_edate);
                    
                    t_where="where=^^"+t_where+"^^";
                    Lock();
					q_gt('view_vcc', t_where, 0, 0, 0,'aaa', r_accy);
                });
                
                $('#btnPrint').click(function() {
                	var t_bnoa=$('#transef_boatname'+0).text();
                	var t_enoa=$('#transef_boatname'+(transef_count-1)).text();
                	if(t_bnoa>t_enoa){
                		var tmp=t_bnoa;
                		t_bnoa=t_enoa;
                		t_enoa=tmp;
                	}
                	                	
                	q_box("z_transef_bv.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({bnoa:trim(t_bnoa),enoa:trim(t_enoa)}) + ";" + r_accy + "_" + r_cno, 'transorde', "95%", "95%", m_print);
				});
            }
            
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			var mouse_point;
			var vcc_n='';//目前vcc的列數
			var transef_count=0;//目前bbs的資料數
			var bbs_n='';//目前觸發的bbs指標
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'show_transef':
						var as = _q_appendData("view_transef", "", true);
						transef_count=as.length;
						var string = "<table id='transef_table' style='width:2400px;'>";
	                    string+='<tr id="transef_header">';
	                    string+='<td id="transef_sel" align="center" style="width:20px; color:black;"></td>';
	                    string+='<td id="transef_boatname" align="center" style="width:160px; color:black;">97條碼</td>';
	                    string+='<td id="transef_po" align="center" style="width:160px; color:black;">96條碼</td>';
	                    string+='<td id="transef_caseuse" align="center" style="width:80px; color:black;">zip</td>';
	                    string+='<td id="transef_accno" align="center" style="width:100px; color:black;">到著所簡碼</td>';
	                    string+='<td id="transef_uccno" align="center" style="width:120px; color:black;">到著所名稱</td>';
	                    string+='<td id="transef_carno" align="center" style="width:60px; color:black;">袋號</td>';
	                    string+='<td id="transef_so" align="center" style="width:120px; color:black;">來源表單編號</td>';
	                    string+='<td id="transef_addressee" align="center" style="width:100px; color:black;">姓名</td>';
	                    string+='<td id="transef_caseend" align="center" style="width:80px; color:black;">郵遞區號</td>';
	                    string+='<td id="transef_aaddr" align="center" style="width:300px; color:black;">地址</td>';
	                    string+='<td id="transef_boat" align="center" style="width:150px; color:black;">行動電話</td>';
	                    string+='<td id="transef_atel" align="center" style="width:150px; color:black;">電話</td>';
	                    string+='<td id="transef_endaddr" align="center" style="color:black;">備註</td>';
	                    string+='<td id="transef_straddr" align="center" style="width:230px; color:black;">商品內容</td>';
	                    string+='<td id="transef_unit" align="center" style="width:80px; color:black;">審件等級</td>';
	                    string+='<td id="transef_price" align="center" style="width:120px; color:black;">代收貨款</td>';
	                    string+='</tr>';
	                    
	                    var t_color = ['DarkBlue','DarkRed'];
	                    for(var i=0;i<as.length;i++){
	                        string+='<tr id="vcc_tr'+i+'">';
	                        string+='<td style="text-align: center; font-weight: bolder; color:black;">'+(i+1)+'</td>';
	                        string+='<td id="transef_boatname'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].boatname+'</td>';
	                        string+='<td id="transef_po'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].po+'</td>';
	                        string+='<td id="transef_caseuse'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].caseuse+'</td>';
	                        string+='<td id="transef_accno'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].accno+'</td>';
	                        string+='<td id="transef_uccno'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].uccno+'</td>';
	                        string+='<td id="transef_carno'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].carno+'</td>';
	                        string+='<td id="transef_so'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].so+'</td>';
	                        string+='<td id="transef_addressee'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].addressee+'</td>';
	                        string+='<td id="transef_caseend'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].caseend+'</td>';
	                        string+='<td id="transef_aaddr'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].aaddr+'</td>';
	                        string+='<td id="transef_boat'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].boat+'</td>';
	                        string+='<td id="transef_atel'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].atel+'</td>';
	                        string+='<td id="transef_endaddr'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].endaddr+'</td>';
	                        string+='<td id="transef_straddr'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].straddr+'</td>';
	                        string+='<td id="transef_unit'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].unit+'</td>';
	                        string+='<td id="transef_price'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].price+'</td>';	                        
	                        string+='</tr>';
	                    }
	                    string+='</table>';
	                    
	                    $('#transef').html(string);
						break;
                    case 'aaa':
                        var GG = _q_appendData("view_vcc", "", true);
                        if (GG[0] != undefined)
                            vcc.init(GG);
                        else{
                            Unlock();
                            alert('無資料。');
                        }
                        break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
                        if(t_name.substring(0,15)=='getvccAccy'){
                            var t_noa = t_name.split('_')[1];
                            var GG = _q_appendData("view_vcc", "", true);
                            if(GG[0]!=undefined){
                                q_box("vcc.aspx?;;;noa='" + t_noa + "';"+GG[0].accy, 'vcc', "95%", "95%", q_getMsg("popvcc"));
                            }else{
                                alert('查無檔案資料。');
                            }
                        }
                        break;
				}
			}
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	
                }
			}
			
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 98%;
				margin: -1px;
				border: 1px black solid;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 9%;
			}
			.tbbm .tdZ {
				width: 2%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}

			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			#vcc_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #vcc_table tr {
                height: 30px;
            }
            #vcc_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: pink;
                color: blue;
            }
            #vcc_header td:hover{
                background : yellow;
                cursor : pointer;
            }
            
            #transef_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #transef_table tr {
                height: 30px;
            }
            #transef_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: bisque;
                color: blue;
            }
		</style>
	</head>
	<body>
		<div id='q_menu'> </div>
		<div id='q_acDiv'> </div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;' value='權限'/>
		<input type='button' id='btnPrint'  style='font-size:16px;' value='列印'/>
		<div id="vcc" style="float:left;width:1260px;"> </div> 
		<div id="vcc_control" style="width:1200px;"> </div> 
		<div id="transef" style="float:left;width:1260px;"> </div> 
		<!--<input type='button' id='btnEnda' style='font-size:16px;float: left;'/>-->
	</body>
</html>