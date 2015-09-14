use Dancer;
use DBI;
use JSON;

my $dbh = DBI->connect( "DBI:mysql:database=horizon;host=localhost", 
    'root', '', { RaiseError => 1, }
) or die "Connection failed";

my $sth = $dbh->prepare("SELECT * FROM borrowers WHERE borrower=?");

get '/borrower/:id' => sub {
    content_type 'application/json';
    $sth->execute(params->{id});
    my $res = $sth->fetchrow_hashref;
    $res ? to_json $res : send_error("Not found", 404);
};

dance
