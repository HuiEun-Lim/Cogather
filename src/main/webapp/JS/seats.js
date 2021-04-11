function checkroom() {
            if (document.getElementById('room').checked) {
                document.getElementById('pickSeat').innerHTML = "<table class='w3-table-all w3-centered'><tr class=" + "test-td" + "><td id=" +
                    "room01" + " >room01</td>" +
                    "<td id=" + "room02" + ">room02</td><td id=" + " room03" + ">room03</td><td id=" + "room04" +
                    " >room04</td></tr><tr><td colspan=" + "4" + ">통로</td>" +
                    "</tr><tr class=" + "test-td" + "><td id=" + "room05" + " >room05</td><td id=" + "room06" + ">room06</td><td id=" +
                    " room07" + ">room07</td><td id=" + "room08" + ">room08</td></tr></table>";
            }
            turnRed();
        }

        function checkprivate() {
            var table = "<table class='w3-table-all w3-centered'>";
            table += "<tr class='test-td'>";
            for (j = 1; j <= 8; j++) {
                table += "<td id='seat" + j + "'>seat" + j + "</td>";
            }
            table += "</tr><tr><td colspan='8'>통로</td></tr>";
            table += "<tr class='test-td'>";
            for (j = 9; j <= 16; j++) {
                table += "<td id='seat" + j + "''>seat" + j + "</td>";
            }
            table += "</tr><tr><td colspan='8'>통로</td></tr>";
            table += "<tr class='test-td'>";
            for (j = 17; j <= 24; j++) {
                table += "<td id='seat" + j + "''>seat" + j + "</td>";
            }
            table += "</tr>";
            table += "</table>"

            document.getElementById('pickSeat').innerHTML = table;

            turnRed();

        }


        function turnRed() {
            $(".test-td td").click(function () {
                var tselect = $(this).text();
               	$(".test-td td").not(tselect).css('color','black');
                document.getElementById(tselect).style.color = 'red';
                document.getElementById("seat_id").value = tselect;
            })
            

        }