#include <cstdio>
#include <cstring>
#include <vector>
#include <queue>
#include <iostream>
#include <map>
#include <sstream>
#include <stdlib.h>

using namespace std;
int N, NP, NC, M;
map<string, int> ID;
const int INF = 1000000009;
int getID(string s) {
    if (!ID.count(s))
        ID[s] = ID.size();
    return ID[s];
}

struct Edge
{
    int u, v, cap;
    Edge() {}
    Edge(int u, int v, int cap): u(u), v(v), cap(cap) {}
} es[200 * 200];
int R, S, T;
vector<int> tab[109]; // 边集
int dis[109];
int current[109];
void addedge(int u, int v, int cap)
{
    tab[u].push_back(R);
    es[R++] = Edge(u, v, cap); // 正向边
    tab[v].push_back(R);
    es[R++] = Edge(v, u, 0); // 反向边容量为0
    // 正向边下标通过异或就得到反向边下标, 2 ^ 1 == 3 ; 3 ^ 1 == 2
}
int BFS()
{
    queue<int> q;
    q.push(S);
    memset(dis, 0x3f, sizeof(dis));
    dis[S] = 0;
    while (!q.empty())
    {
        int h = q.front();
        q.pop();
        for (int i = 0; i < tab[h].size(); i++)
        {
            Edge &e = es[tab[h][i]];
            if (e.cap > 0 && dis[e.v] == 0x3f3f3f3f)
            {
                dis[e.v] = dis[h] + 1;
                q.push(e.v);
            }
        }
    }
    return dis[T] < 0x3f3f3f3f; // 返回是否能够到达汇点
}
int dinic(int x, int maxflow)
{
    if (x == T)
        return maxflow;
    // i = current[x] 当前弧优化
    for (int i = current[x]; i < tab[x].size(); i++)
    {
        current[x] = i;
        Edge &e = es[tab[x][i]];
        if (dis[e.v] == dis[x] + 1 && e.cap > 0)
        {
            int flow = dinic(e.v, min(maxflow, e.cap));
            if (flow)
            {
                e.cap -= flow; // 正向边流量降低
                es[tab[x][i] ^ 1].cap += flow; // 反向边流量增加
                return flow;
            }
        }
    }
    return 0; // 找不到增广路 退出
}
int DINIC()
{
    int ans = 0;
    
    while (BFS()) // 建立分层图
    {
        int flow;
        memset(current, 0, sizeof(current)); // BFS后应当清空当前弧数组
        while (flow = dinic(S, 0x3f3f3f3f)) // 一次BFS可以进行多次增广
            ans += flow;
    }
    return ans;
}
int main()
{
//    freopen("a.txt", "r", stdin);
//    freopen("b.out", "w", stdout);
    int TT;
    scanf("%d", &TT);
    int qq = 1;
    while (TT--) {
        memset(tab, 0, sizeof((tab)));
        R = 0;
        S = 1;
        T = 2;
        int n;
        scanf("%d", &n);
        ID.clear();
        string s, t;
        getline(cin, s);
        for (int i = 1; i <= n; i++) {
            getline(cin, s);
            istringstream ssin(s);
            while (ssin >> t) {
                int x = getID(t)+1;
                addedge(i, n+x*2-1, INF);
                addedge(n+x*2, i, INF);
            }
        }
        for(int i=1; i<=ID.size(); i++)
            addedge(n + 2 * i - 1, n + i * 2, 1);
        printf("Case #%d: ", qq++);
        printf("%d\n", DINIC());
        
    }
    
    return 0;
}
