a = Array.new
a << 0
a << 1
a << 2
a << 3
a << 5
a << 6
a << 7
a << 8
a << 9
a << 10
a << 11
a << 12
a << 14
a << 15
a << 16
a << 17
a << 18
a << 19
a << 20
a << 21
a << 22
b = Array.new
b << 0
b << 1
b << 2
b << 3
b << 5
b << 7
b << 8
b << 9
b << 10
b << 11
b << 12
b << 13
b << 14
b << 15
b << 16
b << 17
b << 18
b << 19
b << 20
b << 21
b << 22
c = Array.new
c << 1
c << 2
c << 4
c << 5
c << 6
c << 7
c << 8
c << 9
c << 10
c << 11
c << 12
c << 13
c << 14
c << 15
c << 16
c << 17
c << 18
c << 19
c << 20
c << 21
c << 22
d = Array.new
d << 0
d << 1
d << 2
d << 3
d << 4
d << 5
d << 6
d << 7
d << 8
d << 9
d << 10
d << 11
d << 12
d << 13
d << 14
d << 15
d << 16
d << 17
d << 18
d << 19
d << 20
d << 21
d << 22
e = Array.new
e << 0
e << 1
e << 2
e << 3
e << 4
e << 5
e << 6
e << 7
e << 8
e << 11
e << 12
e << 13
e << 14
e << 15
e << 16
e << 17
e << 18
e << 19
e << 20
e << 21
e << 22
class Finder
  attr_accessor :a
  def initialize(a)
  	@a = a
  end
  def find
    find_2(0,a.length-1)
  end
  def find_2(s,e)
    if(a[0]==2)
      puts "Finish #{0}, #{1}, missed at the start of array"
      return
    end
    if(a[e]==e)
      puts "Finish #{e+1}, #{e+2}, missed at the end of array"
      return
    end
    m = s+((e-s)/2).floor
    if((s==m)and(a[s]==a[m]))
      puts "Finish #{s+1}, #{s+2}, stand close to each other"
      return
    end
    e_d = a[e] - e
    m_d = a[m] - m
    s_d = a[s] - s
    #puts e_d
    #puts m_d
    #puts s_d
    #puts "find_2, start:#{s},v:#{a[s]}, mid:#{m},v:#{a[m]}, end:#{e},v:#{a[e]}"
    if(m_d == 2)
      find_2(s,m)
    elsif (m_d == 1)
      find_1_a(s,m)
      find_1_b(m,e)
    else
      find_2(m,e)
    end
  end
  def find_1_a(s,e)
    m = s+((e-s)/2).floor
    e_d = a[e] - e
    m_d = a[m] - m
    s_d = a[s] - s
    #puts m_d
    #puts s_d
    #puts "find_1, start:#{s},v:#{a[s]}, mid:#{m},v:#{a[m]}, end:#{e},v:#{a[e]}"
  	if(m == s)
      puts "elem is #{s+1}"
    elsif (m == e)
      puts "elem is #{e+1}"
    elsif (m_d==0)
      find_1_a(m,e)
    else
      find_1_a(s,m)
    end
  end







  def find_1_b(s,e)
    m = s+((e-s)/2).floor
    e_d = a[e] - e
    m_d = a[m] - m
    s_d = a[s] - s
    #puts m_d
    #puts e_d
    #puts "find_1, start:#{s},v:#{a[s]}, mid:#{m},v:#{a[m]}, end:#{e},v:#{a[e]}"
  	if(m == s)
      puts "elem is #{s+2}"
    elsif (e==m)
      puts "elem is #{e+2}"
    elsif (m_d==1)
      find_1_b(m,e)
    else
      find_1_b(s,m)
    end
  end
end

fa = Finder.new(a)
fa.find
fb = Finder.new(b)
fb.find
fc =Finder.new(c)
fc.find
fd =Finder.new(d)
fd.find
fe = Finder.new(e)
fe.find