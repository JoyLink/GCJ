#include<iostream>
#include<algorithm>
#include<stdio.h>
#include<string.h>
#include<math.h>
#include<map>
#include<queue>
#include<sstream>
#define MAXN 250
#define MAXM 250
#define ll long long
using namespace std;
int X[MAXN];
const int INF = 1000000009;
map<string, int> ID;

int getID(string s) {
    if (!ID.count(s))
        ID[s] = ID.size();
    return ID[s];
}
struct Dinic
{
    struct node
    {
        int x,y,c,next;
    }line[MAXM];
    int Lnum,_next[MAXN],dis[MAXN];
    void initial(int n)
    {
        for (int i=0;i<=n;i++) _next[i]=-1;
        Lnum=-1;
    }
    void addline(int x,int y,int c)
    {
        line[++Lnum].next=_next[x],_next[x]=Lnum;
        line[Lnum].x=x,line[Lnum].y=y,line[Lnum].c=c;
        line[++Lnum].next=_next[y],_next[y]=Lnum;
        line[Lnum].x=y,line[Lnum].y=x,line[Lnum].c=c;
    }
    bool BFS(int s,int e)
    {
        queue<int> Q;
        while (!Q.empty()) Q.pop();
        memset(dis,0,sizeof(dis));
        dis[s]=1;
        Q.push(s);
        while (!Q.empty())
        {
            int h,k;
            h=Q.front(),Q.pop();
            if (h==e) return dis[e];
            for (k=_next[h];k!=0;k=line[k].next)
                if (line[k].c && !dis[line[k].y])
                    dis[line[k].y]=dis[h]+1,Q.push(line[k].y);
        }
        return false;
    }
    int dfs(int x,int flow,int e)
    {
        if (x==e) return flow;
        int temp,cost=0;
        for (int k=_next[x];k!=0;k=line[k].next)
            if (line[k].c && dis[line[k].y]==dis[x]+1)
            {
                temp=dfs(line[k].y,min(flow-cost,line[k].c),e);
                if (temp)
                {
                    line[k].c-=temp,line[k^1].c+=temp;
                    cost+=temp;
                    if (flow==cost) return cost;
                }else dis[line[k].y]=-1;
            }
        return cost;
    }
    int MaxFlow(int s,int e)
    {
        int MaxFlow=0;
        while (BFS(s,e))
            MaxFlow+=dfs(s,INF,e);
        return MaxFlow;
    }
}T;

int main()
{
    int TT;
    scanf("%d", &TT);
    while (TT--) {
        int n;
        cin >> n;
        ID.clear();
        string s, t;
        getline(cin, s);
        for (int i = 1; i <= n; i++) {
            getline(cin, s);
            istringstream ssin(s);
            while (ssin >> t) {
                int x = getID(t);
                T.addline(i, n + x * 2 - 1, INF);
                T.addline(n + x * 2, i, INF);
            }
        }
        for(int i=0; i<ID.size(); i++)
            T.addline(n + i + i + 1, n + i * 2 + 2, 1);
        cout<<T.MaxFlow(1, 2);
    }
    return 0;
}
