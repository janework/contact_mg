import $ from 'jquery';
import 'select2';

$( ".select2" ).select2({
    theme: "bootstrap"
});

// Requiring CSS! Path is relative to ./node_modules
import 'select2/dist/css/select2.css';
import 'select2-bootstrap-theme/dist/select2-bootstrap.css';
