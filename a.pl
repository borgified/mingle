#!/usr/bin/env perl

use strict;
use warnings;


# Create a user agent object
use LWP::UserAgent;
my $ua = LWP::UserAgent->new;
$ua->agent("");

# Create a request
#my $req = HTTP::Request->new(GET => 'http://admin:admin@10.3.11.122:8080/api/v2/users.xml');
#my $req = HTTP::Request->new(POST => 'http://admin:admin@10.3.11.122:8080/api/v2/users.xml');
#my $req = HTTP::Request->new(DELETE => 'http://admin:admin@10.3.11.122:8080/api/v2/users/4.xml');

#editing card
my $req = HTTP::Request->new(PUT => 'http://admin:admin@10.3.11.122:8080/api/v2/projects/test1/cards/1.xml');

$req->content_type('application/x-www-form-urlencoded');



my $string = <<EOT
<user>
<name>blaadmin</name>
<login>blahadmin</login>
<email nil="true"/>
<light type="boolean">false</light>
<icon_path nil="true"/>
<activated type="boolean">true</activated>
<admin type="boolean">true</admin>
<version_control_user_name nil="true"/>
<jabber_user_name nil="true"/>
</user>
EOT
;

my $string1 = <<END
user[name]=John Smith
user[login]=john
user[email]=jsmith\@example.com
user[password]=t0ps3cr3t.
user[password_confirmation]=t0ps3cr3t.
user[version_control_user_name]=jsmith
user[jabber_user_name]=jsmith
user[admin]=false
user[light]=false
END
;

my $card = <<CARD
card[name]=hello
CARD
;

$req->content($card);

# Pass request to the user agent and get a response back
my $res = $ua->request($req);

# Check the outcome of the response
if ($res->is_success) {
	print $res->content;
}
else {
	print $res->status_line, "\n";
	print $res->content;
}

