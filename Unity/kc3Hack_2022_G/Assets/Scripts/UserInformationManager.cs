using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UserInformationManager : MonoBehaviour
{
    // 商品の購入回数を、カテゴリ別に管理する用の辞書
    public Dictionary<string, int> itemCounts; 
    
    // Start is called before the first frame update
    void Start()
    {
        DontDestroyOnLoad(this);
        itemCounts = new Dictionary<string, int>();
    }

    public void loadItemCounts()
    {
        // 一旦辞書内を初期化する
        itemCounts.Clear();

        // ここで購入回数を読み込む
        for (int i = 0; i < 0; i++) {
            Debug.Log("^ ~~ ^");
        }
        // テスト用
        itemCounts.Add("onigiri", 1);
        itemCounts.Add("shokupan", 1);
        itemCounts.Add("soda", 1);
        itemCounts.Add("chicken", 1);

        Debug.Log("Loading Complete.");
    }
}
