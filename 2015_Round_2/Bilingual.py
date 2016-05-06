inp = open('C-small-practice.in')
out = open('B-large-practice.out', "w")

debug_model = True


class edge(object):
    def __init__(self, u, v, cap, flow):
        self.u = u
        self.v = v
        self.cap = cap
        self.flow = flow

m = {}
edges = []
G = [[0] for j in xrange(250)]
cur =  [0 for i in xrange(250)]
d = [0 for i in xrange(250)]
infi = 999999999999999

s, t = -1, -1

def add(u, v, cap) :
    edges.append(edge(u, v, cap, 0))
    G[u].append(len(edges) - 1)
    edges.append(edge(v, u, 0, 0))
    G[v].append(len(edges) - 1)

def bfs():
    vis = [0 for i in xrange(250)]
    vis[s] = 1
    queue = [s]
    d[s] = 0
    while queue:
        u = queue.pop(0)
        for i in xrange(1, len(G[u])):
            e = edges[G[u][i]]
            if vis[e.v] == 1 or e.cap == e.flow:
                continue
            d[e.v] = d[u]+1
            vis[e.v]=1
            queue.append(e.v)
    return vis[t] > 0

def dfs(u, a):
    if u == t or a == 0:
        return a
    flow, f, i = 0, 0, cur[u]
    for i in xrange(1, len(G[u])):
        e = edges[G[u][i]]
        f = dfs(e.v, min(a, e.cap-e.flow))
        if d[e.v] == d[u]+1 and f > 0:
            edges[G[u][i]].flow+=f
            edges[G[u][i]^1].flow-=f
            flow+=f
            a-=f
            if a == 0:
                break

    return flow

def dinic():
    flow, x = 0, 0
    while bfs():
        cur = [0 for i in xrange(250)]
        x = dfs(s, infi)
        while x != 0:
            flow+=x
            cur = [0 for i in xrange(250)]
            x = dfs(s, infi)

    return flow

T = int(raw_input()) if debug_model else int(inp.readline())
for i in xrange(T):
    m = {}
    s = 1
    t = 2
    N = int(raw_input()) if debug_model else int(inp.readline())
    G = [[0] for j in xrange(250)]
    d = [0 for x in xrange(250)]
    for j in xrange(1, N+1):
        string = raw_input().split()
        for c in string:
            if not c in m:
                m[c] = len(m) + 1
            add(j, N+2*m[c]-1, infi)
            add(N+2*m[c], j, infi)
    for j in xrange(len(m)):
        add(N+2*j+1, N+2*j+2, 1)
    if debug_model:
        print "Case #" + str(i+1) + ": " + str(dinic())
    else:
        out.write("Case #" + str(i+1) + ": " + str(dinic()) + '\n')




