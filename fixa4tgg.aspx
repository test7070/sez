<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
		    this.errorHandler = null;
		    function onPageError(error) {
		        alert("An error occurred:\r\n" + error.Message);
		    }

		    q_tables = 's';
		    var q_name = "fixa4tgg";
		    var q_readonly = ['txtNoa','txtTggno','txtTgg','txtMoney','txtWorker','txtWorker2'];
		    var q_readonlys = ['txtMoney','txtBfixadate'];
		    var bbmNum = new Array(['txtMoney', 10, 0, 1]);
		    var bbsNum = new Array(['txtPrice', 10, 1,1], ['txtMount', 10, 1,1], ['txtMoney', 10, 0,1], ['txtMile', 10, 0,1]);
		    var bbmMask = [];
		    var bbsMask = [];
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'noa';
		    //ajaxPath = "";
		    aPop = new Array();
		    q_desc = 1;
			
			t_data = null;
			function fixa4tgg() {
            }
            fixa4tgg.prototype = {
            	tggno : '',
            	tgg : '',
            	nick : '',
            	_count : 10,
            	carList : new Array(),
            	carplateList : new Array(),
                productList : new Array(),
                tmpArray : new Array(),
                tmpField : new Array(),
                curIndex : -1,
                curObj : null,
                init : function(){
            		t_option = '';
                	t_option += '<div class="tmpList" style="background:yellow; width:500px; height:25px;">'
	                	+'<input class="tmpList" type="button" id="tmpList_btnPrevious" value="◄" style="float:left;width:30px;height:25px;"/>'
				    	+'<a class="tmpList" id="tmpList_curIndex" style="float:left;display:block; width:215px;height:25px;text-align: right;"> </a>'
					    +'<a class="tmpList" style="float:left;display:block; width:10px;height:25px;">/</a>'
					    +'<a class="tmpList" id="tmpList_totPage" style="float:left;display:block; width:215px;height:25px;"> </a>'
					    +'<input class="tmpList" type="button" id="tmpList_btnNext" value="►" style="float:left;width:30px;height:25px;"/>'
					+'</div>';
					for(var i=0;i<this._count;i++){
						t_option +='<div class="tmpList" style="background:yellow; width:500px; height:25px;">'
							+'<a class="tmpList" style="float:left;display:block; width:20px;height:25px;"> </a>'
							+'<a class="tmpList" id="tmpList_noa_'+i+'" style="float:left;display:block; width:100px;height:25px;"> </a>'
			                +'<a class="tmpList" id="tmpList_namea_'+i+'" style="float:left;display:block; width:280px;height:25px;"> </a>'
			                +'<a class="tmpList" id="tmpList_price_'+i+'" style="float:left;display:block; width:100px;height:25px;text-align: right"> </a>'
			            +'</div>';
					}
					$('#tmpList').hide().html(t_option);
					$('#tmpList_btnPrevious').click(function(e){
               			if(t_data.curIndex > 0)
               				t_data.listShow(t_data.curObj,'',t_data.curIndex-1,t_data.tmpArray,t_data.tmpField);
               		});
               		$('#tmpList_btnNext').click(function(e){
               			if(t_data.curIndex < Math.ceil(t_data.tmpArray.length/t_data._count)-1)
               				t_data.listShow(t_data.curObj,'',t_data.curIndex+1,t_data.tmpArray,t_data.tmpField);
               		});
               		
               		$('body').focus(function(e){
			   			if($(this).data('curFocus')==undefined)
			   				$(this).data('bFocus',null);
			   			else
			   				$(this).data('bFocus',$(this).data('curFocus'));
			   			$(this).data('curFocus',$(e.target));
			   		}).click(function(e){
			   			if(!($(e.target).hasClass('tmpList') || ($(e.target).attr('id')!=undefined && $(e.target).attr('id').split('_')[0]==$('#tmpList').data('target')))){
			   				t_data.listHide();
			   			}
			   		});
                },
                listShow : function(obj,key,nn,tArray,tField){
                	if(!(q_cur==1 || q_cur==2))
                		return;
                	this.tmpArray = tArray.concat();
                	this.tmpField = tField.concat();
                	this.curObj = obj;
                	if(key.length>0)
	                	for(var i=0;i<this.tmpArray.length;i++){
	                		if(this.tmpArray[i].noa.toUpperCase().indexOf(key.toUpperCase() )>=0
	                			|| this.tmpArray[i].namea.toUpperCase().indexOf(key.toUpperCase())>=0){
	                		}else{
	                			this.tmpArray.splice(i,1);
	                			i--;
	                		}	
	                	}
                	t_option = '';
                	if(nn>=0){
                		this.curIndex = nn;
                	}else{
                		this.curIndex = 0;
                	}
                	for(var i=0;i<this._count;i++){
            			n = this.curIndex*this._count + i;
            			if(n<this.tmpArray.length){
            				$('#tmpList_noa_'+i).parent().attr('tag',n).show();
        					$('#tmpList_noa_'+i).html(this.tmpArray[n].noa);
        					$('#tmpList_namea_'+i).html(this.tmpArray[n].namea);
        					if(this.tmpArray[n].price!=undefined)
        						$('#tmpList_price_'+i).html(this.tmpArray[n].price);
        					else
        						$('#tmpList_price_'+i).html('');
            			}else{
            				$('#tmpList_noa_'+i).parent().removeAttr('tag').hide();
        					$('#tmpList_noa_'+i).html('');
        					$('#tmpList_namea_'+i).html('');
        					$('#tmpList_price_'+i).html('');
            			}
            		}
                	$('#tmpList_curIndex').html(this.curIndex+1);
                	$('#tmpList_totPage').html(Math.ceil(this.tmpArray.length/this._count));
                	
                	$('#tmpList').attr('tag',obj.attr('id').split('_')[1]).show().css('top',obj.offset().top+obj.height()).css('left',obj.offset().left);
               		$('#tmpList').data('target',obj.attr('id').split('_')[0]);
               		$('#tmpList').children().children().hover(function(e){
               			if($(this).parent().attr('tag')!=undefined)
               				$(this).parent().css('background','orange');
               		},function(e){
               			if($(this).parent().attr('tag')!=undefined)
               				$(this).parent().css('background','yellow');
               		}).click(function(e){
               			var n = $(this).parent().attr('tag');
               			var m = $(this).parent().parent().attr('tag');
               			if(n!=undefined && m!=undefined){
               				if(t_data.tmpField.length>0)
               					$('#'+t_data.tmpField[0]+'_'+m).val(t_data.tmpArray[n].noa);
               				if(t_data.tmpField.length>1 && t_data.tmpField[1].length>0)
	               				$('#'+t_data.tmpField[1]+'_'+m).val(t_data.tmpArray[n].namea);
	               			if(t_data.tmpField.length>2 && t_data.tmpField[2].length>0)
	               				$('#'+t_data.tmpField[2]+'_'+m).val(t_data.tmpArray[n].price);
	               			$('#tmpList').hide();
	               			getBfixadate(m);
               			}
               		});
               		
                },  
                listHide : function(){
                	$('#tmpList').hide();
                },
            };
            function getBfixadate(n){
            	Lock(1,{opacity:0});
    			var t_fixadate = $.trim($('#txtDatea').val());
    			var t_carno = '';
    			var t_carplateno = '';
    			var t_productno = $.trim($('#txtProductno_'+n).val());;
    			
    			for(var i=n;i>=0;i--){
    				t_carno = $.trim($('#txtCarno_'+i).val());
    				if(t_carno.length>0)
    					break;
    				t_carplateno = $.trim($('#txtCarplateno_'+i).val());
    				if(t_carplateno.length>0)
    					break;
    			}
    			
    			if(t_carno.length==0 || t_productno.length==0){
    				Unlock(1);
    				return false;
    			}
    			var t_where ="";
    			if(t_carplateno.length==0)
    				t_where ="where=^^ (b.noa is not null) and b.productno='"+t_productno+"' and a.carno='"+t_carno+"' and len(isnull(a.carplateno,''))=0 and a.fixadate<'"+t_fixadate+"' ^^";
        		else
        			t_where ="where=^^ (b.noa is not null) and b.productno='"+t_productno+"' and a.carplateno='"+t_carplateno+"' and a.fixadate<'"+t_fixadate+"' ^^";
        		q_gt('fixa_lasttime', t_where, 0, 0, 0,'fixalasttime_'+n, r_accy);
            }
            
		    $(document).ready(function () {
		    	t_data = new fixa4tgg();
            	t_data.init();
		   		
		        bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
		        q_brwCount();
		        q_content="where=^^ tggno='"+r_userno+"'^^";
		        q_gt(q_name,q_content, q_sqlCount, 1);
		    });

		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainForm(1);
		    } 

		    function pop(form) {
		        b_pop = form;
		    }

		    function mainPost() {
		        q_getFormat();
		        bbmMask = [['txtDatea', r_picd]];
		        q_mask(bbmMask);
		        $('#txtDatea').datepicker();
		        q_gt("fixucc", "where=^^ left(noa,"+(r_userno.length+1)+")='"+r_userno+"-' ^^", 0, 0, 0, "getProduct");
		 		
		    }
		    function q_boxClose(s2) {
		        var ret;
		        switch (b_pop) {
		            case q_name + '_s':
		                q_boxClose2(s2);
		                break;
		        }  
		    }
		    function q_gtPost(t_name) {
		        switch (t_name) {
		        	case 'getProduct':
                        var as = _q_appendData("fixucc", "", true);
                        for ( i = 0; i < as.length; i++) {
                        	t_data.productList.push({noa : as[i].noa,namea : as[i].namea,price : as[i].inprice});
                        }
                        q_gt("car2", "where=^^ a.cartype='2' ^^", 0, 0, 0, "getCar");
                        break;
                    case 'getCar':
                    	var as = _q_appendData("car2", "", true);
                    	for ( i = 0; i < as.length; i++) {
                        	t_data.carList.push({noa : as[i].carno,namea:as[i].driver});
                        }
                        q_gt("carplate", '', 0, 0, 0, "getCarplate");
                    	break;
                   	case 'getCarplate':
                    	var as = _q_appendData("carplate", "", true);
                    	for ( i = 0; i < as.length; i++) {
                        	t_data.carplateList.push({noa : as[i].noa,namea:as[i].carplate});
                        }
                    	q_gt("tgg", "where=^^ noa='"+r_userno+"' ^^", 0, 0, 0, "getTgg");
                    	break;
                    case 'getTgg':
                    	var as = _q_appendData("tgg", "", true);
                    	if(as[0]!=undefined){
                    		t_data.tggno=as[0].noa;
                    		t_data.tgg=as[0].comp;
                    		t_data.nick=as[0].nick;
                    	}
                    	break;
		            case q_name:
		                if (q_cur == 4)
		                    q_Seek_gtPost();
		                break;
		            default:
		            	if(t_name.substring(0,12)=='fixalasttime'){
		            		var sel = parseInt(t_name.split('_')[1]);
		            		var as = _q_appendData("fixa", "", true);
                        	if (as[0] != undefined) {
                        		$('#txtBfixadate_'+sel).val(as[0].fixadate);
                        	}else{
                        		
                        	}
                        	sum();
                        	Unlock(1);
		            	}
		            	break;
		        }
		    }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
		    function btnOk() {
		    	Lock(1,{opacity:0});
	            if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
 		        sum();
                if(q_cur ==1){
	            	$('#txtWorker').val(r_name);
	            }else if(q_cur ==2){
	            	$('#txtWorker2').val(r_name);
	            }else{
	            	alert("error: btnok!");
	            }
		        var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_fixa4tgg') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)// 1-3
		            return;
		        q_box('fixa4tgg_s.aspx', q_name + '_s', "550px", "350px", q_getMsg("popSeek"));
		    }

		    function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		        	$('#lblNo_'+i).text(i+1);
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		                $('#txtProductno_' + i).focus(function(e){
		                	t_data.listShow($(this),$(this).val(),-1,t_data.productList,['txtProductno','txtProduct','txtPrice']);
		                }).keyup(function(e){
		                	t_data.listShow($(this),$(this).val(),-1,t_data.productList,['txtProductno','txtProduct','txtPrice']);
		                }).keydown(function(e){
		                	if(e.which==13 || e.which==9)
		                		t_data.listHide();
		                }).change(function(e){
		                	var n = $(this).attr('id').replace('txtProductno_','');
		                	getBfixadate(n);
		                });
		                $('#txtCarno_' + i).focus(function(e){
		                	t_data.listShow($(this),$(this).val(),-1,t_data.carList,['txtCarno']);
		                }).keyup(function(e){
		                	t_data.listShow($(this),$(this).val(),-1,t_data.carList,['txtCarno']);
		                }).keydown(function(e){
		                	if(e.which==13 || e.which==9)
		                		t_data.listHide();
		                }).change(function(e){
		                	var n = $(this).attr('id').replace('txtProductno_');
		                	getBfixadate(n);
		                });
		                $('#txtCarplateno_' + i).focus(function(e){
		                	t_data.listShow($(this),$(this).val(),-1,t_data.carplateList,['txtCarplateno','']);
		                }).keyup(function(e){
		                	t_data.listShow($(this),$(this).val(),-1,t_data.carplateList,['txtCarplateno','']);
		                }).keydown(function(e){
		                	if(e.which==13 || e.which==9)
		                		t_data.listHide();
		                }).change(function(e){
		                	var n = $(this).attr('id').replace('txtProductno_');
		                	getBfixadate(n);
		                });
		                $('#txtMount_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtPrice_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtMoney_' + i).change(function (e) {
		                    sum();
		                });
		            }
		        }
		        _bbsAssign();
		    }

		    function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                if($('#txtDatea').val().length==0)
               		$('#txtDatea').val(q_date());
               	$('#txtTggno').val(t_data.tggno);
               	$('#txtTgg').val(t_data.tgg);
               	$('#txtNick').val(t_data.nick);
		        $('#txtDatea').focus();
		    }

		    function btnModi() {
		        if ($('#txtNoa').val().length==0)
                    return;
                _btnModi();       
                $('#txtDatea').focus();
		    }

		    function btnPrint() {
				q_box("z_fixa4tgg.aspx?;;;;"+r_accy, 'z_fixa4tgg', "95%", "95%", q_getMsg("popFixa4tgg"));
		    }

		    function wrServer(key_value) {
		        var i;
		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
		    }

		    function bbsSave(as) {
		        if (!as['productno'] && !as['product']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        return true;
		    }
		    function q_popPost(t_id) {
		    	switch(t_id){
		    		default:
		    			break;
		    	}
            }

		    function sum() {
		    	if(!(q_cur==1 || q_cur==2))
		    		return;
		        var t_money = 0,t_moneys;
		        for (var j = 0; j < q_bbsCount; j++) {
		        	t_moneys = q_float('txtMount_' + j).mul(q_float('txtPrice_' + j)).round(0);
		        	$('#txtMoney_'+j).val(FormatNumber(t_moneys));
		        	t_money += t_moneys;
		        }
		        $('#txtMoney').val(FormatNumber(t_money));
		    }

		    function refresh(recno) {
		        _refresh(recno);
		    }
		    function readonly(t_para, empty) {
		        _readonly(t_para, empty);
		    }

		    function btnMinus(id) {
		        _btnMinus(id);
		        sum();
		    }

		    function btnPlus(org_htm, dest_tag, afield) {
		        _btnPlus(org_htm, dest_tag, afield);
		    }

		    function q_appendData(t_Table) {
		        return _q_appendData(t_Table);
		    }

		    function btnSeek() {
		        _btnSeek();
		    }

		    function btnTop() {
		        _btnTop();
		    }

		    function btnPrev() {
		        _btnPrev();
		    }

		    function btnPrevPage() {
		        _btnPrevPage();
		    }

		    function btnNext() {
		        _btnNext();
		    }

		    function btnNextPage() {
		        _btnNextPage();
		    }

		    function btnBott() {
		        _btnBott();
		    }

		    function q_brwAssign(s1) {
		        _q_brwAssign(s1);
		    }

		    function btnDele() {
		        _btnDele();
		    }

		    function btnCancel() {
		        _btnCancel();
		    }
			function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
			Number.prototype.round = function(arg) {
			    return Math.round(this.mul( Math.pow(10,arg))).div( Math.pow(10,arg));
			};
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			};
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length; } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length; } catch (e) { }
			    with (Math) {
			        r1 = Number(arg1.toString().replace(".", ""));
			        r2 = Number(arg2.toString().replace(".", ""));
			        return (r1 / r2) * pow(10, t2 - t1);
			    }
			}
			Number.prototype.mul = function(arg) {
			    return accMul(arg, this);
			};
			function accMul(arg1, arg2) {
			    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
			    try { m += s1.split(".")[1].length; } catch (e) { }
			    try { m += s2.split(".")[1].length; } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
			}
			Number.prototype.add = function(arg) {
		   		return accAdd(arg, this);
			};
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length; } catch (e) { r1 = 0; }
			    try { r2 = arg2.toString().split(".")[1].length; } catch (e) { r2 = 0; }
			    m = Math.pow(10, Math.max(r1, r2));
			    return (Math.round(arg1 * m) + Math.round(arg2 * m)) / m;
			}
			Number.prototype.sub = function(arg) {
			    return accSub(this,arg);
			};
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length; } catch (e) { r1 = 0; }
			    try { r2 = arg2.toString().split(".")[1].length; } catch (e) { r2 = 0; }
			    m = Math.pow(10, Math.max(r1, r2));
			    n = (r1 >= r2) ? r1 : r2;
			    return parseFloat(((Math.round(arg1 * m) - Math.round(arg2 * m)) / m).toFixed(n));
			}
		</script>
		<style type="text/css">
			#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 400px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 550px;
                /*margin: -1px;        
                border: 1px black solid;*/
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            }
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="tmpList" class="productList" style="position: absolute;"> </div>
		<div id='dmain' >
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:15%"><a id='vewMoney'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td align="center" id=datea>~datea</td>
						<td id="money,0,1" style="text-align: right;">~money,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm" >
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno" type="text" class="txt"  style="width:25%;"/>
							<input id="txtTgg" type="text" class="txt" style="width:75%;"/>
							<input id="txtNick" type="text" class="txt" style="display: none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>			
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="4"><input id="txtMemo" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px;"><a id='lblCarno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCarplateno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMile_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					
					<td align="center" style="width:80px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblBfixadate_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input class="txt c1" id="txtCarno.*" type="text" /></td>
					<td><input class="txt c1" id="txtCarplateno.*" type="text" /></td>
					<td><input class="txt num c1" id="txtMile.*" type="text" /></td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="float:left;width:35%;"/>
						<input class="txt" id="txtProduct.*"type="text" style="float:left;width:60%;"/>
					</td>
					<td><input class="txt num c1" id="txtPrice.*" type="text" /></td>
					<td><input class="txt num c1" id="txtMount.*" type="text" /></td>
					<td><input class="txt num c1" id="txtMoney.*" type="text" /></td>
					<td><input class="txt c1" id="txtMemo.*" type="text" /></td>
					<td><input class="txt c1" id="txtBfixadate.*" type="text" /></td>
				</tr>
				
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
