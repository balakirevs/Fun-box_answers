require 'benchmark'
people = Array.new;
class Person
  attr_accessor :sex, :age, :height, :index, :money, :id
  def initialize(id)
    @sex = 1-rand(2)
    @age = rand(100)
    @height = rand(300)
    @index = rand(100000)
    @money = rand(100000)
    @id = id
  end
  def to_s
    return "Person of sex#{@sex} with age of: #{@age} and height of: #{@height}"
  end
end
class Finder
  attr_accessor :sex, :age, :height, :index, :money, :people
  def initialize(people)
    @sex = Array.new
    @age = Array.new
    @height = Array.new
    @index = Array.new
    @money = Array.new
    @p = people
    for i in 0 .. people.length-1
      p = people[i]
      @sex[p.sex] = Array.new if @sex[p.sex] == nil
      @sex[p.sex].push(p)
      @age[p.age] = Array.new if @age[p.age] == nil
      @age[p.age].push(p)
      @height[p.height] = Array.new if @height[p.height] == nil
      @height[p.height].push(p)
      @index[p.index] = Array.new if @index[p.index] == nil
      @index[p.index].push(p)
      @money[p.money] = Array.new if @money[p.money] == nil
      @money[p.money].push(p)
    end
  end
  def prferred_field(s,a_s,a_e,h_s,h_e,i_s,i_e,m_s,m_e)
    r = Array.new
    Benchmark.bm do |b|
      b.report("get preferred array") do
        l = @p.length
        s_w = l/2
        a_w = l/100
        h_w = l/300
        i_w = l/100000
        m_w = l/100000
        a = (a_e - a_s+1)*a_w
        h = (h_e - h_s+1)*h_w
        i = (i_e - i_s+1)*i_w
        m = (m_e - m_s+1)*m_w
        
        if((s_w<a) and (s_w<h) and (s_w<i) and (s_w<m))
          r =  @sex[s] if @sex[i]!=nil
          puts "sex is!"
        elsif((a<s_w) and (a<h) and (a<i) and (a<m))
          puts "age is!"
          for i in a_s .. a_e
            r = r+@age[i] if @age[i]!=nil
          end
        elsif((h<s_w) and (h<a) and (h<i) and (h<m))
          puts "height is!"
          for i in h_s .. h_e
            r = r+@height[i] if @height[i]!=nil
          end
        elsif((i<s_w) and (i<h) and (i<a) and (i<m))
          puts "index is!"
          for i in i_s .. i_e
            r = r+@index[i] if @index[i]!=nil
          end
        elsif((m<s_w) and (m<h) and (m<i) and (m<a))
          puts "money is!"
          for i in m_s .. m_e
            r = r+@money[i] if @money[i]!=nil
          end
        else
          r =  @p
        end
      end
    end
    return r
  end
  def print_sex
    puts "male is #{@sex[0].length}"
  end
  def print_age
    puts "male is #{@age[10].length}"
  end
  def print_sex_and_age
    x = @sex[1] & @age[20]
    puts "age and sex #{x.length}" 
  end
  def simple_find(s,a_s,a_e,h_s,h_e,i_s,i_e,m_s,m_e)
    fin = Array.new
    Benchmark.bm do |b|
      b.report("simple find") do
        for i in 0 .. @p.length - 1
          #puts "age is fine #{@p[i].age}" if((@p[i].age>=a_s)and(@p[i].age<=a_e))
          fin << i if((@p[i].sex==s) and ((@p[i].age>=a_s)and(@p[i].age<=a_e)) and ((@p[i].height>=h_s)and(@p[i].height<=h_e)) and ((@p[i].index>=i_s)and(@p[i].index<=i_e)) and ((@p[i].money>=m_s)and(@p[i].money<=m_e)))
        end
      end
    end
    return fin
  end  
  def imp_find(s,a_s,a_e,h_s,h_e,i_s,i_e,m_s,m_e)
    a = prferred_field(s,a_s,a_e,h_s,h_e,i_s,i_e,m_s,m_e)
    fin = Array.new
    #puts a
    Benchmark.bm do |b|
      b.report("simple find") do
        for i in 0 .. a.length - 1
          #puts "age is fine #{@p[i].age}" if((@p[i].age>=a_s)and(@p[i].age<=a_e))
          fin << a[i] if((a[i].sex==s) and ((a[i].age>=a_s)and(a[i].age<=a_e)) and ((a[i].height>=h_s)and(a[i].height<=h_e)) and ((a[i].index>=i_s)and(a[i].index<=i_e)) and ((a[i].money>=m_s)and(a[i].money<=m_e)))
        end
      end
    end
    return fin
  end
  def find(s,a_s,a_e,h_s,h_e,i_s,i_e,m_s,m_e)
    s_a = Array.new
    a_a = Array.new
    h_a = Array.new
    i_a = Array.new
    m_a = Array.new
    fin = Array.new
    Benchmark.bm do |b|
      b.report("sex") do
        #s_a = @sex[s]
        for y in 0 .. @sex[s].length - 1 
          s_a.push(@sex[s][y])
        end
      end
      b.report("age") do
        for i in a_s .. a_e
          next if @age[i] == nil
          for y in 0 .. @age[i].length - 1 
            a_a.push(@age[i][y])
          end
        end
      end
      b.report("height") do
        for i in h_s .. h_e
          next if @height[i] == nil
          for y in 0 .. @height[i].length - 1 
            h_a.push(@height[i][y])
          end
        end
      end
      b.report("index") do
        for i in i_s .. i_e
          next if @index[i] == nil
          for y in 0 .. @index[i].length - 1 
            i_a.push(@index[i][y])
          end
        end
      end
      b.report("money") do
        for i in h_s .. h_e
          next if @money[i] == nil
          for y in 0 .. @money[i].length - 1 
            m_a.push(@money[i][y])
          end
        end
      end 
      b.report("finish") do
        fin = s_a & a_a & h_a & i_a & m_a
      end
      return fin
    end
  end
end
#p = Person.new
#puts p.to_s
for i in 1 .. 10000000
  people.push(Person.new(i))
end
#puts people.length

f = Finder.new(people)
#f.print_age
#f.print_sex_and_age
#puts "before search"
#Benchmark.bm do |b|
 # b.report("find") do
#x = f.find(1, 1, 1, 1, 300, 1, 100000, 1, 100000)
#puts "Onswer #{x.length}"
#puts x
#x.each do |p|
#  person = people[p-1]
#  puts person
#end
y = f.simple_find(1, 1, 2, 1, 300, 1, 100000, 1, 5000)
puts "Simpole onswer #{y.length}"

z = f.imp_find(1, 1, 2, 1, 300, 1, 100000, 1, 5000)
puts "Preferred array #{z.length}"


#y.each do |p|
#  person = people[p]
#  puts person
#end
  #end
  #b.report("sex") do
  #  f.print_sex
  #end
#end