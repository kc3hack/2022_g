using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{

    // ゲーム中かどうか
    bool inGaming = false;
    [SerializeField] SceneChanger sc;

    void Start()
    {
        DontDestroyOnLoad(this);    // シーン変更時にGameObjectが消えないようにする
    }


    // ゲームスタート
    public void toGaming() {
        inGaming = true;
        sc.ChangeScene("GameScene");
    }

}
