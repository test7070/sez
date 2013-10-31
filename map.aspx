<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title> </title>
    
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    
     <script src="../script/jquery.min.js" type="text/javascript"> </script>
    <script src='../script/qj2.js' type="text/javascript"> </script>
    <script src='qset.js' type="text/javascript"> </script>
    <script src='../script/qj_mess.js' type="text/javascript"> </script>
    <script src="../script/qbox.js" type="text/javascript"> </script>
    <script src='../script/mask.js' type="text/javascript"> </script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA-t9mxfqERP-8cyhynUwLtwQvT7VxKP04&sensor=true">
    </script>
    
    <script type="text/javascript">
    	
    	var map,mapOptions,marker,myLatlng;//地圖
    	var locations;
    	
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        var q_name = "location";
        var q_readonly = [];
        var bbmNum = []; 
        var bbmMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
		brwCount2=10
        aPop = new Array();

        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1)
            //$('#txtNoa').focus
        });

        //////////////////   end Ready
        function main() {
            if (dataErr) {
                dataErr = false;
                return;
            }
            mainForm(0); // 1=Last  0=Top
        }  ///  end Main()

        function mainPost() {
        		$('#btnModi').attr('hidden', 'true');
        		$('#btnDele').attr('hidden', 'true');
        		$('#btnSeek').attr('hidden', 'true');
        		$('#btnPrint').attr('hidden', 'true');
        		$('#btnPrevPage').attr('hidden', 'true');
        		$('#btnPrev').attr('hidden', 'true');
        		$('#btnNext').attr('hidden', 'true');
        		$('#btnNextPage').attr('hidden', 'true');
        		$('#btnAuthority').attr('hidden', 'true');
        		$('#btnSign').attr('hidden', 'true');
        		$('#pageNow').attr('hidden', 'true');
        		$('#pageAll').attr('hidden', 'true');
        		$('#btnIns').attr('hidden', 'true');
        		$('#btnOk').attr('hidden', 'true');
        		$('#btnCancel').attr('hidden', 'true');
        		$('#dmain').attr('hidden', 'true');
        		initialize();
        }
        
        function q_stPost() {
            if (!(q_cur == 1 || q_cur == 2))
                return false;
        }

        function q_boxClose(s2) {
            var ret;
            switch (b_pop) {
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }

        function q_gtPost(t_name) {
            switch (t_name) {
                case q_name:
                	locations=_q_appendData("location", "", true);                	

                	if (q_cur == 4)
                        q_Seek_gtPost();

                    if (q_cur == 1 || q_cur == 2)
                        q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);
                    break;
            }  /// end switch
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
        }

        function btnIns() {
            _btnIns();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
        }

        function btnPrint() {

        }
        function btnOk() {
            var t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);

            if(t_err.length > 0) {
            	alert(t_err);
                return;
            }
			
			var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            wrServer(s1);
        }

        function wrServer(key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '', '', 2);
        }

        function refresh(recno) {
            _refresh(recno);
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
        }

        function btnMinus(id) {
            _btnMinus(id);
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
            if (q_tables == 's')
                bbsAssign();  /// 
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
        
        function initialize() {
			//地圖建立
			myLatlng=new google.maps.LatLng(22.669193,120.308327);
			mapOptions = {
				center: myLatlng,
				zoom: 13,
				mapTypeId: google.maps.MapTypeId.ROADMAP
			};
			
			map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions);
			
			window.setInterval(mark,3000); //定時建立mark
		}
        
        //建立mark
		function mark() {
			//清除marker
			if (marker) {
				for (i in marker) {
					marker[i].setMap(null);
				}
			}
			
			//插入marker
			for(var i=0;i<myLatlng.length;i++){
				myLatlng[i]=new google.maps.LatLng(locations[i].latitude,locations[i].longitude)	
				marker[i] = new google.maps.Marker({
					position: myLatlng[i],
					map: map,
					title:"我是"+locations[i].noa
				});
			}
			q_gt('location','', 0, 0, 0, "", r_accy);
		}
        ////////////////////////////////////////////////////////////////////////////////
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
                width: 10%;
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
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
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
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
            
            html { height: 100% }
      		body { height: 100%; margin: 0; padding: 0 }
             #map_canvas { height: 100%; }
			
        </style>
    </head>
    <body>
            <!--#include file="../inc/toolbar.inc"-->
            <div id='dmain' >
            	<div class="dview" id="dview">
                    <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66; width: 100%;">
                        <tr>
                            <td align="center" style="width:5%"><a id='vewChk'></a></td>
                             <td align="center" style="width:5%"><a id='vewNoa'></a></td>
                        </tr>
                        <tr>
                            <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                            <td align="center" id='noa'>~noa</td>
                        </tr>
                    </table>
                </div>
                <div class='dbbm' style="float: left;">
                    <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
                        <tr class="tr1">
                            <td class="td1"><span> </span>	<a id='lblNoa' class="lbl"></a></td>
                            <td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
                            <td class="td3"><span> </span>	<a id='lblLatitude' class="lbl"></a></td>
                            <td class="td1"><input id="txtLatitude"  type="text"  class="txt c1"/></td>
                            <td class="td2"><span> </span>	<a id='lblLongitude' class="lbl"></a></td>
                            <td class="td3"><input id="txtLongitude"  type="text"  class="txt c1"/></td>
                        </tr>
                </table>
            </div>
         </div>
         	<div id="map_canvas" style="width:100%; height:100%;z-index: 0;"></div>
            <input id="q_sys" type="hidden" />
    </body>
</html>

