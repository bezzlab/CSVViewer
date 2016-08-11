<%
    import os
    import ConfigParser

    root = h.url_for( "/" )
    app_root = root + "plugins/visualizations/csvviewer/static/"

    galaxy_root_dir = os.getcwd()
    galaxy_ini_file = os.path.join(galaxy_root_dir,'config/galaxy.ini')
    config          = ConfigParser.ConfigParser()
    config.read(galaxy_ini_file)

    output_dir      = config.get('MzIdentML', 'output_dir')
    error_report_to = config.get('MzIdentML', 'error_report_to')
    rel_output_dir = config.get('MzIdentML', 'rel_output_dir')
%>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>MzIdentML Viewer</title>
        <!--Import Google Icon Font-->
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- ${h.stylesheet_link( app_root + 'css/materialize.min.css' )} -->
        ${h.stylesheet_link( app_root + 'css/jquery.dataTables.min.css' )}
        <!-- ${h.stylesheet_link( app_root + 'css/proviewer.css' )} -->

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    </head>
    <body>
        <div class="container">
            <div>
                <table id="protein-table" class="display" width="100%"></table>
            </div>
        </div>
        ${h.javascript_link( app_root + 'js/jquery-2.2.1.min.js' )}
        ${h.javascript_link( app_root + 'js/jquery.dataTables.min.js' )}
        <script type="text/javascript" charset="utf-8">

        $(document).ready(function() {

            var proteintable;
            var rootLocation = "${galaxy_root_dir}"; // "/Users/myname/Downloads/galaxy";
            var dataLocation = "${rel_output_dir}";  // "/plugins/visualizations/csvviewer/static/data/";
            var hdaId     = "${trans.security.encode_id( hda.id )}";
            var inputFile = "${hda.file_name}";
            var filetype = "${hda.ext}";
            //var jsondata;

            console.log("filetype : " + filetype);
            var json_array_data = [
    [ "Tiger Nixon", "System Architect", "Edinburgh", "5421", "2011/04/25", "$320,800" ],
    [ "Garrett Winters", "Accountant", "Tokyo", "8422", "2011/07/25", "$170,750" ],
    [ "Ashton Cox", "Junior Technical Author", "San Francisco", "1562", "2009/01/12", "$86,000" ],
    [ "Cedric Kelly", "Senior Javascript Developer", "Edinburgh", "6224", "2012/03/29", "$433,060" ],
    [ "Airi Satou", "Accountant", "Tokyo", "5407", "2008/11/28", "$162,700" ],
    [ "Brielle Williamson", "Integration Specialist", "New York", "4804", "2012/12/02", "$372,000" ],
    [ "Herrod Chandler", "Sales Assistant", "San Francisco", "9608", "2012/08/06", "$137,500" ],
    [ "Rhona Davidson", "Integration Specialist", "Tokyo", "6200", "2010/10/14", "$327,900" ],
    [ "Colleen Hurst", "Javascript Developer", "San Francisco", "2360", "2009/09/15", "$205,500" ],
    [ "Sonya Frost", "Software Engineer", "Edinburgh", "1667", "2008/12/13", "$103,600" ],
    [ "Jena Gaines", "Office Manager", "London", "3814", "2008/12/19", "$90,560" ],
    [ "Quinn Flynn", "Support Lead", "Edinburgh", "9497", "2013/03/03", "$342,000" ],
    [ "Charde Marshall", "Regional Director", "San Francisco", "6741", "2008/10/16", "$470,600" ],
    [ "Haley Kennedy", "Senior Marketing Designer", "London", "3597", "2012/12/18", "$313,500" ],
    [ "Tatyana Fitzpatrick", "Regional Director", "London", "1965", "2010/03/17", "$385,750" ],
    [ "Michael Silva", "Marketing Designer", "London", "1581", "2012/11/27", "$198,500" ],
    [ "Paul Byrd", "Chief Financial Officer (CFO)", "New York", "3059", "2010/06/09", "$725,000" ],
    [ "Gloria Little", "Systems Administrator", "New York", "1721", "2009/04/10", "$237,500" ],
    [ "Bradley Greer", "Software Engineer", "London", "2558", "2012/10/13", "$132,000" ],
    [ "Dai Rios", "Personnel Lead", "Edinburgh", "2290", "2012/09/26", "$217,500" ],
    [ "Jenette Caldwell", "Development Lead", "New York", "1937", "2011/09/03", "$345,000" ],
    ];

            var jsondata = [
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"sp|Q15149-4|PLEC_HUMAN","Pass Threshold (Protein)":true,"description":"sp|Q15149-4|PLEC_HUMAN Isoform 4 of Plectin OS=Homo sapiens GN=PLEC","group membership":"anchor protein","distinct peptide sequences":291,"ProteoGrouper:PDH score":31567.29841,"razor peptides":"","cluster identifier":46},
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"tr|E9PQ28|E9PQ28_HUMAN","Pass Threshold (Protein)":true,"description":"tr|E9PQ28|E9PQ28_HUMAN Plectin (Fragment) OS=Homo sapiens GN=PLEC PE=1 SV=1","group membership":"sequence sub-set protein:PDH_217","distinct peptide sequences":3,"ProteoGrouper:PDH score":268.3901766,"razor peptides":"","cluster identifier":46},
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"tr|E9PIA2|E9PIA2_HUMAN","Pass Threshold (Protein)":true,"description":"tr|E9PIA2|E9PIA2_HUMAN Plectin (Fragment) OS=Homo sapiens GN=PLEC PE=1 SV=1","group membership":"sequence sub-set protein:PDH_217","distinct peptide sequences":4,"ProteoGrouper:PDH score":365.4028252,"razor peptides":"","cluster identifier":46},
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"tr|E9PKG0|E9PKG0_HUMAN","Pass Threshold (Protein)":true,"description":"tr|E9PKG0|E9PKG0_HUMAN Plectin (Fragment) OS=Homo sapiens GN=PLEC PE=1 SV=1","group membership":"sequence sub-set protein:PDH_217","distinct peptide sequences":7,"ProteoGrouper:PDH score":682.781595,"razor peptides":"","cluster identifier":46},
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"tr|H0YDN1|H0YDN1_HUMAN","Pass Threshold (Protein)":true,"description":"tr|H0YDN1|H0YDN1_HUMAN Plectin (Fragment) OS=Homo sapiens GN=PLEC PE=1 SV=5","group membership":"sequence sub-set protein:PDH_217","distinct peptide sequences":11,"ProteoGrouper:PDH score":1441.012446,"razor peptides":"","cluster identifier":46},
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"tr|E9PMV1|E9PMV1_HUMAN","Pass Threshold (Protein)":true,"description":"tr|E9PMV1|E9PMV1_HUMAN Plectin (Fragment) OS=Homo sapiens GN=PLEC PE=1 SV=1","group membership":"sequence sub-set protein:PDH_217","distinct peptide sequences":31,"ProteoGrouper:PDH score":3504.388343,"razor peptides":"","cluster identifier":46},
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"sp|Q15149-9|PLEC_HUMAN","Pass Threshold (Protein)":true,"description":"sp|Q15149-9|PLEC_HUMAN Isoform 9 of Plectin OS=Homo sapiens GN=PLEC","group membership":"sequence sub-set protein:PDH_217","distinct peptide sequences":290,"ProteoGrouper:PDH score":31404.06944,"razor peptides":"","cluster identifier":46},
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"sp|Q15149-8|PLEC_HUMAN","Pass Threshold (Protein)":true,"description":"sp|Q15149-8|PLEC_HUMAN Isoform 8 of Plectin OS=Homo sapiens GN=PLEC","group membership":"sequence sub-set protein:PDH_217","distinct peptide sequences":290,"ProteoGrouper:PDH score":31404.06944,"razor peptides":"","cluster identifier":46},
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"sp|Q15149-7|PLEC_HUMAN","Pass Threshold (Protein)":true,"description":"sp|Q15149-7|PLEC_HUMAN Isoform 7 of Plectin OS=Homo sapiens GN=PLEC","group membership":"sequence sub-set protein:PDH_217","distinct peptide sequences":290,"ProteoGrouper:PDH score":31404.06944,"razor peptides":"","cluster identifier":46},
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"sp|Q15149-6|PLEC_HUMAN","Pass Threshold (Protein)":true,"description":"sp|Q15149-6|PLEC_HUMAN Isoform 6 of Plectin OS=Homo sapiens GN=PLEC","group membership":"sequence sub-set protein:PDH_217","distinct peptide sequences":290,"ProteoGrouper:PDH score":31404.06944,"razor peptides":"","cluster identifier":46},
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"sp|Q15149-5|PLEC_HUMAN","Pass Threshold (Protein)":true,"description":"sp|Q15149-5|PLEC_HUMAN Isoform 5 of Plectin OS=Homo sapiens GN=PLEC","group membership":"sequence sub-set protein:PDH_217","distinct peptide sequences":290,"ProteoGrouper:PDH score":31404.06944,"razor peptides":"","cluster identifier":46},
{"PAG ID":"PAG_0","PAG score":16446.73739,"protein accession":"sp|Q15149-2|PLEC_HUMAN","Pass Threshold (Protein)":true,"description":"sp|Q15149-2|PLEC_HUMAN Isoform 2 of Plectin OS=Homo sapiens GN=PLEC","group membership":"sequence sub-set protein:PDH_217","distinct peptide sequences":290,"ProteoGrouper:PDH score":31404.06944,"razor peptides":"","cluster identifier":46}
];
            $.ajax({
                type: "GET",
                url: "/plugins/visualizations/csvviewer/static/data/dataset_4.dat",
                success: function(data) {
                    console.log("SUCCESS !!!");
                   // jsondata = CSVToArray(data, ',');
                    alert("done");
                    console.log(jsondata);
                },
                error: function(data) {
                    console.log("error !!!");
                }
            });

               $('#protein-table').DataTable( {
                    "dataType": "json",
                    data: jsondata
                } );

            // //var csv is the CSV file with headers
            // function csvJSON(csv){

            //     var lines=csv.split("\n");
            //     var result = [];
            //     var headers=lines[0].split(",");
            //     for(var i=1;i<lines.length;i++){
            //         var obj = {};
            //         var currentline=lines[i].split(",");
            //         for(var j=0;j<headers.length;j++){
            //             obj[headers[j]] = currentline[j];
            //         }
            //         result.push(obj);
            //     }
            //     //return result; //JavaScript object
            //     return JSON.stringify(result); //JSON
            // }
        });
        </script>
        <script type="text/javascript">
    // ref: http://stackoverflow.com/a/1293163/2343
    // This will parse a delimited string into an array of
    // arrays. The default delimiter is the comma, but this
    // can be overriden in the second argument.
    function CSVToArray( strData, strDelimiter ){
        // Check to see if the delimiter is defined. If not,
        // then default to comma.
        strDelimiter = (strDelimiter || ",");

        // Create a regular expression to parse the CSV values.
        var objPattern = new RegExp(
            (
                // Delimiters.
                "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +

                // Quoted fields.
                "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +

                // Standard fields.
                "([^\"\\" + strDelimiter + "\\r\\n]*))"
            ),
            "gi"
            );


        // Create an array to hold our data. Give the array
        // a default empty first row.
        var arrData = [[]];

        // Create an array to hold our individual pattern
        // matching groups.
        var arrMatches = null;


        // Keep looping over the regular expression matches
        // until we can no longer find a match.
        while (arrMatches = objPattern.exec( strData )){

            // Get the delimiter that was found.
            var strMatchedDelimiter = arrMatches[ 1 ];

            // Check to see if the given delimiter has a length
            // (is not the start of string) and if it matches
            // field delimiter. If id does not, then we know
            // that this delimiter is a row delimiter.
            if (
                strMatchedDelimiter.length &&
                strMatchedDelimiter !== strDelimiter
                ){

                // Since we have reached a new row of data,
                // add an empty row to our data array.
                arrData.push( [] );

            }

            var strMatchedValue;

            // Now that we have our delimiter out of the way,
            // let's check to see which kind of value we
            // captured (quoted or unquoted).
            if (arrMatches[ 2 ]){

                // We found a quoted value. When we capture
                // this value, unescape any double quotes.
                strMatchedValue = arrMatches[ 2 ].replace(
                    new RegExp( "\"\"", "g" ),
                    "\""
                    );

            } else {

                // We found a non-quoted value.
                strMatchedValue = arrMatches[ 3 ];

            }


            // Now that we have our value string, let's add
            // it to the data array.
            arrData[ arrData.length - 1 ].push( strMatchedValue );
        }

        // for (var i=0, l=arrData.length; i<l; i++){
        //     if (arrData[i] instanceof Array){
        //         arrData[i] = arrData[i].join("`");
        //     }
        // }

        // Return the parsed data.
        return( arrData );
    }

</script>
    </body>
    </html>
