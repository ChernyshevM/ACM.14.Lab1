package ST03;
use strict;
my %menu_items = (
   1 => ["�뢮� ᯨ᪠ ����", \&list],
   2 => ["�������� �����", \&add],
   3 => ["������஢���� ����", \&edit],
   4 => ["�������� ����", \&remove],
   5 => ["���࠭���� � 䠩�", \&backup],
   6 => ["�⥭�� �� 䠩��", \&restore]
);

my @data;

sub menu {
    while (1) {
        print "\n";
        print "---------------------------------------\n";
        foreach my $n (sort keys %menu_items) {
            print "$n. $menu_items{$n}->[0]\n";
        }
        print "---------------------------------------\n";
        print "�롥�� ����� �㭪�, ��� 0 ��� ��室�: ";
        chomp(my $answer = <STDIN>);
        last unless $answer;
        if (exists $menu_items{$answer}) {
            $menu_items{$answer}->[1]->();
        }
        else {
            print "�訡��! ������ �� ࠧ: \n";
        }
    }    
}

sub list {
    print "���᮪ ����.\n";
    foreach my $i (0..$#data) {
        my $number = $i+1;
        print "$number. $data[$i]->[0] \"$data[$i]->[1]\", $data[$i]->[2]\n";
    }
}

sub add {
    print "���������� ����.\n";
    while (1) {
        print "��� �����襭�� ������ ����� �⢥��\n";
        print "������ ����: ";
        chomp(my $autor = <STDIN>);
        print "������ ��������: ";
        chomp(my $title = <STDIN>);
        print "������ ��� �������: ";
        chomp(my $year = <STDIN>);
        
        last unless $autor . $title . $year;
        push @data, [$autor, $title, $year];

        print "����� ���������\n\n";
    }    
}

sub edit {
    print "������஢���� ����\n";
    while (1) {
        print "������ ����� ����� ��� ।���஢���� (���� ��� �����襭��):";
        chomp(my $number = <STDIN>);
        last unless $number;
        
        if (($number > 0) and ($number <= $#data+1)) {
            my $i = $number - 1; 
            print "$number. $data[$i]->[0] \"$data[$i]->[1]\", $data[$i]->[2]\n";
            print "���⮩ �⢥� ��⠢�� ���� ��� ��������\n";
            print "������ ����: ";
            chomp(my $autor = <STDIN>);
            $autor = $data[$i]->[0] unless $autor;
            print "������ ��������: ";
            chomp(my $title = <STDIN>);
            $title = $data[$i]->[1] unless $title;
            print "������ ��� �������: ";
            chomp(my $year = <STDIN>);
            $year = $data[$i]->[2] unless $year;
            
            $data[$i] = [$autor, $title, $year];

            print "����� ��������\n\n";
        }
        else {
            print "������ ����� �����\n\n";
        }    
    }    
}

sub remove {
    print "�������� ����\n";
    while (1) {
        print "������ ����� ����� ��� 㤠����� (���� ��� �����襭��):";
        chomp(my $number = <STDIN>);
        last unless $number;
        
        if (($number > 0) and ($number <= $#data+1)) {
            my $i = $number - 1; 
            print "$number. $data[$i]->[0] \"$data[$i]->[1]\", $data[$i]->[2]\n";
            print "���⮩ �⢥� ��⠢�� ���� ��� ��������\n";
            print "�⮡� ���⢥न�� 㤠�����, ������ 1 ";
            chomp(my $answer = <STDIN>);
            if ($answer) {
                splice @data, $i, 1;
                print "����� 㤠����\n\n";
            }
            else {
                print "�������� �⬥����\n\n";
            }    
        }
        else {
            print "͍����� ����� �����, ������ �����\n\n";
        }    
    }    
}

sub backup {
    print "���࠭���� ᯨ᪠ ���� � 䠩�.\n";
    print "������ ��� 䠩�� ��� ��࠭���� (���� ��� �⬥��):";
    chomp(my $file = <STDIN>);
    if ($file) {
        my %hash;
        if (dbmopen(%hash, $file, 0644)) {
            foreach my $i (0..$#data) {
                $hash{$i} = join("##", @{$data[$i]});
            }
            dbmclose(%hash);
            print "���࠭���� �믮�����\n\n";
        }
        else {
            print "�訡�� �� ࠡ�� � 䠩���\n\n";
        }    
    }
    else {
        print "������ �⬥����\n\n";
    }    
}

sub restore {
    print "�⥭�� ᯨ᪠ ���� �� 䠩��.\n";
    print "������ ��� 䠩�� ��� �⥭�� (���� ��� �⬥��):";
    chomp(my $file = <STDIN>);
    if ($file) {
        my %hash;
        if (dbmopen(%hash, $file, 0644)) {
            @data = ();
            foreach my $i (sort keys %hash) {
                push @data, [split("##", $hash{$i})];
            }
            dbmclose(%hash);
            print "�⥭�� �믮�����\n\n";
        }
        else {
            print "�訡�� �� ࠡ�� � 䠩���\n\n";
        }    
    }
    else {
        print "������ �⬥����\n\n";
    }    
}
sub st03 {
menu();
}
return 1;
