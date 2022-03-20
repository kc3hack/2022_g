using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DontDestroy : MonoBehaviour
{
    void Start()
    {
        DontDestroyOnLoad(this);    // ƒV[ƒ“•ÏX‚ÉGameObject‚ªÁ‚¦‚È‚¢‚æ‚¤‚É‚·‚é
    }
}
