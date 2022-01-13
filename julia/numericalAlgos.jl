
#distance between two points in 2D plane
  function point_distance2D(x1, y1, x2, y2)
      return sqrt(((x2 - x1) ^ 2) + ((y2 - y1) ^ 2))
  end
  
#distance between two points in 3D plane
  function point_distance3D(x1, y1, z1, x2, y2, z2)
      return sqrt(((x2 - x1) ^ 2) + ((y2 - y1) ^ 2) + ((z2 - z1) ^ 2))
  end
  
  #point_distance2D(3., 4., 4., 3.) 
  #point_distance3D(1., 0., 2., 9., 4., 9.)
  
  #calculate the hypotenuse of a triangle
  function hypotenuse(x,y)
    x = abs(x)
    y = abs(y)
    if x > y
      r = y/x
      return x*sqrt(1+r*r)
    end
    if y == 0
      return zero(x)
    end
    r = x/y
    return y*sqrt(1+r*r)
  end
  
  #hypotenuse(3,4)
  
  #area of a triangle using points
  function triangle_coordinates_area(x1, x2, x3, y1, y2, y3)
      A = [x1 y1 1; x2 y2 1; x3 y3 1]
      area = 0.5 * abs(det(A))
      return area
  end
  
  #triangle_coordinates_area(-1, 0, 1, 0, 1, 0)
  
  #absolute error
  function absError(real, approx)
      return (approx - real)
  end
  
  #real error
  function realError(real, approx)
      return approx / real
  end
  
  #Function for creating a Hilbert Matrix
  function createHilbert(n) 
      H = zeros(n, n) #declare a null array of nxn dimension.
      for i = 1:n
          for j = 1:n
              H[i,j] = 1 / (i + j - 1) 
          end
      end
      return H 
  end
  
  #createHilbert(5)
  
  #trapezoid method
  function trapezoidMethod(f, a, b, n)
      h = (b - a) / n
      s = .5 * (f(a) + f(b))
      for i =1:(n - 1)
          x = a + i * h
          s = s + f(x)
      end
      return s * h
  end
  
  function f1(x)
      fn = sin(x)
      return fn
  end
  
  #trapezoidMethod(f1, 0, pi, 100) #returns 1.9998355038874436. 
    
  #Newton's Method
  function newtonMethod(f,f_prime,x,tolerance,precision,display,steps)
      fx = f(x)
      for i = 1:steps
          if abs(f_prime(x)) < precision
              print("small derivative")
              break
          end
          d = fx / f_prime(x)
          x = x - d
          fx = f(x)
          if display == 1
                  print([i, x, fx])
          end
          if abs(d) < tolerance
              print("convergence")
              break
          end
      end
  end
  
  function testfn(x)
      fn = sin(x)
      return fn
  end
  
  function testfnprime(x)
      fn = cos(x)
      return fn
  end
  
  #newton(testfn, testfnprime, 1.2, 0.00000001, 0.00000001, 1, 25)
  
  #secant method
  function secant(f, a, b, precision, steps)
      fa = f(a)
      fb = f(b)
      if abs(fa) > abs(fb)
          temp = a
          a = b
          b = temp
          temp = fa
          fa = fb
          fb = temp
      end
      print([0,a,fa])
      print([1,b,fb])
      for n = 2:steps
          if abs(fa) > abs(fb)
              temp = a
              a = b
              b = temp
              temp = fa
              fa = fb
              fb = temp
          end
          d = (b - a) / (fb - fa)
          b = a
          fb = fa
          d = d * fa
          if abs(d) < precision
              print("Convergence")
              print([n, a, fa])
          end
          a = a - d
          fa = f(a)
      end
  end
  
  function secantfn(x)
      fn = (e^x)-3*(x^2)
      return fn
  end
  
  #secant(secantfn, -0.5, 2. ,1. ^ -10, 25)
  #found root to be -0.45896257524. There are other roots at 0.91 and 3.733
  
  #Cramer's Rule
  #Ax=b, where A is an nxn matrix and b is an 1xn matrix
  #evaluate x1, x2, ..., xn using Cramer's Rule
  
  function cramers_rule2(a1, a2, a3, a4, b1, b2)
      A = [a1 a2;a3 a4]
      if det(A) == 0
          print("Cramer's rule does not apply.")
      else
          A1 = [b1 a2;b2 a4] 
          A2 = [a1 b1;a3 b2]
          x1 = det(A1) / det(A)
          x2 = det(A2) / det(A)
      end
      return [x1;x2]
  end
  
  function cramers_rule3(a1, a2, a3, a4, a5, a6, a7, a8, a9, b1, b2, b3)
      A = [a1 a2 a3;a4 a5 a6;a7 a8 a9]
      if det(A) == 0
          print("Cramer's rule does not apply.")
      else
          A1 = [b1 a2 a3;b2 a5 a6;b3 a8 a9]  #replace the first column with the matrix b.
          A2 = [a1 b1 a3;a4 b2 a6;a7 b3 a9]  #replace the second column with the matrix b.
          A3 = [a1 a2 b1;a4 a5 b2;a7 a8 b3]  #replace the third column with the matrix b.
          x1 = det(A1) / det(A)
          x2 = det(A2) / det(A)
          x3 = det(A3) / det(A)
      end
      return [x1;x2;x3]
  end
  
  #cramers_rule2(7., -2., 3., 1., 3., 5.)
  #cramers_rule3(1., 0., 2., -3., 4., 6., -1., -2., 3., 6., 30., 8.)
  
  #simpson's Method
  function simpson(f, a, b, level, level_max, precision)
      level += 1
      h = b - a
      c = (a + b) / 2
      one_s = h * (f(a) + 4. * f(c) + f(b)) / 6.
      d = (a + c) / 2
      e = (c + b) / 2
      two_s = h * (f(a) + 4. * f(d) + 2. * f(c) + 4. * f(e) + f(b)) / 12.
      if level >= level_max
          simpson_result = two_s
          print("Max level reached")
          return simpson_result
      else
          if abs(two_s - one_s) < 15. * precision
              return two_s + (two_s - one_s) / 15.
          else
              left_s = simpson(f, a, c, level, level_max, precision / 2.)
              right_s = simpson(f, c, b, level, level_max, precision / 2.)
              print(left_s)
              return left_s + right_s
          end
      end
  end
  
  function simptest(x)
      fn = x^2
      return fn
  end
  
  #simpson(simptest, -2, 2, 0.000000000000001, 1, 10) #returns 5.333333333333.
  
  #Gaussian Quadrature
  #Two point Gaussian Quadrature
  function twoPointGauss(f, a, b, n)
      h = (b - a) / n
      #print h
      sum = 0
      for i = 1:n-1
          x0 = a + (i * h) #starting at left end point, h represents step size.
          #print x0
          x1 = x0 + (0.5 * h) * (1 - sqrt(1 / 3))
          #print x1
          x2 = x0 + (0.5 * h) * (1 + sqrt(1 / 3))
          #print x2
          sum += ((f(x1) + f(x2))) #weights are 1.
          #print sum
      end
      sum *= (0.5 * h)
      return sum
  end
  
  #Three point Gaussian Quadrature
  function threePointGauss(f, a, b, n)
      h = (b - a) / n
      #print h
      sum = 0
      for i = 1:n-1
          x0 = a + (i * h) #starting at left end point, h represents step size.
          #print x0
          x1 = x0 + (0.5 * h) * (1 - sqrt(3 / 5))
          #print x1
          x2 = x0 + (0.5 * h)
          #print x2
          x3 = x0 + (0.5 * h) * (1 + sqrt(3 / 5))
          #print x3
          sum += (((5 / 9) * f(x1)) + ((8 / 9) * f(x2)) + ((5 / 9) * f(x3))) #weights are 5/9, 8/9, and 5/9.
          #print sum
      end
      sum *= (0.5 * h)
      return sum
  end
  
  
  function f(x)
      fn = x^5
      return fn
  end
  
  #twoPointGauss(f,0.,1.,10) #result is 0.16666512500000005
  #threePointGauss(f,0.,1.,10) #result is 0.16666650000000005
  
  #Runge-Kutta methods

  #f denotes the function, x denotes the initial point, a and b denote the beginning and end of the interval, n denotes number of iterations.
  # Runge-Kutta of order 2.
  function runge_kutta_2(f, x, a, b, n)
      h = (b - a) / n  # step size
      t = a  # sets the initial t as the left-most point of the interval, a.
      for j = 1:n
          k1 = h * f(t, x)
          k2 = h * f(t + h, x + k1)
          x += 0.5 * (k1 + k2)
          t = a + (j * h)
          print([j, t, x])
      end
  end
  
  # Runge-Kutta method of order 4.
  function runge_kutta_4(f, x, a, b, n)
      h = (b - a) / n  # step size
      t = a  # sets the initial t as the left-most point of the interval, a.
      for j = 1:n
          k1 = h * f(t, x)
          k2 = h * f(t + 0.5 * h, x + 0.5 * k1)
          k3 = h * f(t + 0.5 * h, x + 0.5 * k2)
          k4 = h * f(t + h, x + k3)
          x += (1. / 6.) * (k1 + 2. * k2 + 2. * k3 + k4)
          t = a + (j * h)
          print([j, t, x])
      end
  end
  
  # test function given in book.
  function f(t, x)
      fn = 2. + ((x - t - 1.) ^ 2.)
      return fn
  end
  
  #another test function
  function g(t,x)
      fn = 3. + (5 * sin(t)) + (0.2 * x)
      return fn
  end
  
  ##tests using f(t,x):
  #runge_kutta_2(f, 2., 1., 1.5625, 72) #returns 3.192942728232579
  #runge_kutta_4(f, 2., 1., 1,5625, 72) #returns 3.192937673837072
  ##tests using g(t,x):
  #runge_kutta_2(g, 0., 0., 10., 1000) #returns 135.91667314003618
  #runge_kutta_4(g, 0., 0., 10., 1000) #returns 135.91724460992168

  #Convert polar coordinates to cartesian coordinates
  function polars_to_cartesian(r, d)
      theta = (d * pi) / 180.
      x = r*cos(theta)
      y = r*sin(theta)
      return x, y
  end
  
  #polars_to_cartesian(3, 30)
