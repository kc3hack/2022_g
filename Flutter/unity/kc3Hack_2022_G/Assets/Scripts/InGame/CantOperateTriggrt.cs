using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CantOperateTriggrt : MonoBehaviour
{
    [SerializeField] InGameManager igm;
    
    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (igm.currentItemGO != null)
        {
            if (collision.gameObject == igm.currentItemGO)
            {
                if (igm.currentItem != null)
                {
                    igm.currentItem.finishOperate();
                }
            }
        }
    }

}
