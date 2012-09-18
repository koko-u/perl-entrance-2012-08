use Mojolicious::Lite;
use utf8;

get '/' => sub {
	my $self = shift;

	$self->stash(name => '');
	$self->render();
} => 'index';

app->start;

__DATA__
@@ index.html.ep
<html>
<head><title><%= $name %>'s website</title></head>
<body style='padding: 30px;'>
<a href='/profile'>Profile</a>
</body>
</html>

@@ profile.html.ep
<html>
<head><title><%= $name %>のプロフィール</title></head>
<body style='padding: 30px;'>
私の名前は<%= $name %>です.<br>
趣味は<%= $hobby %>で, 好きなプログラミング言語は<%= $language %>です.
</body>
</html>
