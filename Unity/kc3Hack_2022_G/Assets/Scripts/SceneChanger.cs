using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneChanger : MonoBehaviour
{

    private void Start()
    {
        DontDestroyOnLoad(this);
    }

    // シーン変更用のメソッド  sceneNameで遷移先Scene指定
    public void ChangeScene(string sceneName)
    {
        switch (sceneName)
        {
            case "GameScene":
                Invoke("ChangeToGameScene", 1.0f);
                break;
            default:
                Debug.Log("SceneNameError");
                break;
        }

    }

    // GameSceneに遷移する用のメソッド
    public void ChangeToGameScene()
    {
        SceneManager.LoadScene("GameScene");
    }
}
