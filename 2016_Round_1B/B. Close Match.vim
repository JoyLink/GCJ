inp = open('B-large-practice.in')
out = open('B-large-practice.out', "w")

def sovle(equal, ansc, ansj, lc, inx, C, J):
    for j in xrange(inx, lc):
        if inx == lc:
            return (ansc, ansj)

        if C[j].isdigit() and J[j].isdigit():
            ansc += C[j]
            ansj += J[j]
            if equal == 1 and C[j] > J[j]:
                equal = 0
            elif equal == 1 and C[j] < J[j]:
                equal = 2
        if C[j].isdigit() and not J[j].isdigit():

            if equal == 1:

                a1 = sovle(1, ansc+C[j], ansj+C[j], lc, j+1, C, J)
                tac1, taj1 = a1[0], a1[1]
                m = abs(int(tac1)-int(taj1))


                if C[j] > '0':
                    a2 = sovle(0, ansc+C[j], ansj+str(int(C[j])-1), lc, j+1, C, J)
                    tac2, taj2 = a2[0], a2[1]
                    m = min(m, abs(int(tac2) - int(taj2)))
                if C[j] < '9':
                    a3 = sovle(2, ansc+C[j], ansj+str(int(C[j])+1), lc, j+1, C, J)
                    tac3, taj3 = a3[0], a3[1]
                    m = min(m, abs(int(tac3) - int(taj3)))

                if C[j] > '0' and m == abs(int(tac2) - int(taj2)):
                    return (tac2, taj2)
                elif m == abs(int(tac1)-int(taj1)):
                    return (tac1, taj1)
                else:
                    return (tac3, taj3)

            elif equal == 0:
                ansc += C[j]
                ansj += '9'
            elif equal == 2:
                ansc += C[j]
                ansj += '0'
        if not C[j].isdigit() and J[j].isdigit():

            if equal == 1:

                if i == 60:
                    print 'hi'
                a1 = sovle(1, ansc+J[j], ansj+J[j], lc, j+1, C, J)
                tac1, taj1 = a1[0], a1[1]
                m = abs(int(tac1) - int(taj1))

                if J[j] > '0':
                    a2 = sovle(2, ansc+str(int(J[j])-1), ansj+J[j], lc, j+1, C, J)
                    tac2, taj2 = a2[0], a2[1]
                    m = min(m, abs(int(tac2)-int(taj2)))
                if J[j] < '9':
                    a3 = sovle(0, ansc+str(int(J[j])+1), ansj+J[j], lc, j+1, C, J)
                    tac3, taj3 = a3[0], a3[1]
                    m = min(m, abs(int(tac3)-int(taj3)))

                if J[j] > '0' and m == abs(int(tac2)-int(taj2)):
                    return (tac2, taj2)
                elif m == abs(int(tac1) - int(taj1)):
                    return (tac1, taj1)
                else:
                    return (tac3, taj3)

            elif equal == 0:
                ansj += J[j]
                ansc += '0'
            elif equal == 2:
                ansj += J[j]
                ansc += '9'
        if not C[j].isdigit() and not J[j].isdigit():
            if equal == 1:
                a1 = sovle(1, ansc+'0', ansj+'0', lc, j+1, C, J)
                tac1, taj1 = a1[0], a1[1]
                a2 = sovle(0, ansc+'1', ansj+'0', lc, j+1, C, J)
                tac2, taj2 = a2[0], a2[1]
                a3 = sovle(2, ansc+'0', ansj+'1', lc, j+1, C, J)
                tac3, taj3 = a3[0], a3[1]
                d1 = abs(int(tac1)-int(taj1))
                d2 = abs(int(tac2)-int(taj2))
                d3 = abs(int(tac3)-int(taj3))
                m = min(d1, d2, d3)

                if d1 == m:
                    return (tac1, taj1)
                elif d2 == m:
                    return (tac2, taj2)
                elif d3 == m:
                    return (tac3, taj3)

            elif equal == 0:
                ansc += '0'
                ansj += '9'
            elif equal == 2:
                ansc += '9'
                ansj += '0'
    return (ansc, ansj)

T = int(inp.readline())
for i in xrange(T):
    IN = inp.readline().split()
    C, J = IN[0], IN[1]
    equal = 1
    ansc, ansj = '', ''
    ans = sovle(1, ansc, ansj, len(C), 0,  C, J)
    ans1, ans2 = ans[0], ans[1]
    while len(ans1) < len(C):
        ans1 = '0' + ans1
    while len(ans2) < len(C):
        ans2 = '0' + ans2
    out.write("Case #" + str(i+1) + ": " + ans1 + " " + ans2 + '\n')







